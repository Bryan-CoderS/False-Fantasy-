extends CharacterBody2D


const SPEED = 300.0
const ACCELERATION = 1000.0
const JUMP_VELOCITY = -600.0
const BOUNCE_VELOCITY = -1300

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#var save_file_path = "user://save"
#var save_file_name = "PlayerSave.tres"
#var playerData = PlayerData.new()
#var player_position_x
#var player_position_y 
var playerPos: Vector2
var health = Global.hp
var is_dying = false
var is_r_dying = false
var right_slip = false
var left_slip = false


@onready var _animated_sprite = $MainCharacterSprite
@onready var all_interactions = []
@onready var interactLabel = $"Interaction Components/InteractLabel"
@onready var bounce_raycast = $BonceRayCast

func _ready():
#	verify_save_directory(save_file_path)
	update_interactions()
	update_health()
#	load_file()

func _process(delta):
	pass


func _physics_process(delta):
	update_health()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if right_slip == true:
		print("slip")
		global_position.x += ACCELERATION * delta
		_animated_sprite.play("run")
		_animated_sprite.flip_h = false
		
	if left_slip == true:
		print("slip")
		global_position.x -= ACCELERATION * delta
		_animated_sprite.play("run")
		_animated_sprite.flip_h = true
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.	
	if Input.is_action_pressed("move_left"):
		global_position.x -= SPEED * delta
		_animated_sprite.play("run")
		_animated_sprite.flip_h = true
#		velocity.x -= SPEED * delta
	elif Input.is_action_pressed("move_right"):
		global_position.x += SPEED * delta
		_animated_sprite.play("run")
		_animated_sprite.flip_h = false
#		velocity.x += SPEED * delta
	elif Input.is_action_pressed("move_down"):
		global_position.y += SPEED * delta
	else:
		_animated_sprite.play("stand")
	_check_bounce(delta)
	move_and_slide()
	
	if Input.is_action_just_pressed("Interact"):
		execute_interactions()
	
	if Global.hp <= 0:
		is_r_dying = true
		
		if is_r_dying:
			is_r_dying = false
			get_tree().change_scene_to_file("res://black_2_0.tscn")
		
	


func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()


func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()
	

func update_interactions():
	if all_interactions:
		interactLabel.text = all_interactions[0].interact_label
	else:
		interactLabel.text = ""
		

func execute_interactions():
	if all_interactions:
		var cur_interactions = all_interactions[0]
		match cur_interactions.interact_type:
			"print_text" : print(cur_interactions.interact_value)

func _check_bounce(delta):
	if velocity.y > 0:
		for raycast in bounce_raycast.get_children():
			raycast.target_position = Vector2.DOWN * velocity * delta + Vector2.DOWN
			raycast.force_raycast_update()
			if raycast.is_colliding() && raycast.get_collision_normal() == Vector2.UP:
				velocity.y = (raycast.get_collision_point() - raycast.global_position - Vector2.DOWN).y / delta
				raycast.get_collider().entity.call_deferred("be_bounced_upon", self)
				break
	
func bounce(bounce_velocity = BOUNCE_VELOCITY):
	velocity.y = bounce_velocity


func _on_area_2d_body_entered(body):
	bounce()

func update_health():
	var health = Global.hp 
	var healthbar = $HealthBar
	healthbar.value = health

func _on_right_slip_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	right_slip = true

func _on_right_slip_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	right_slip = false

func _on_left_slip_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	left_slip = true

func _on_left_slip_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	left_slip = false
