extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -400.0
var is_dying = true
var is_r_dying = false
var health = Global.hp

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	await get_tree().create_timer(2.0).timeout


func _physics_process(delta):
	update_health()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		velocity.x += SPEED * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("move_left"):
#		global_position.x -= SPEED * delta
		$FsSlime.flip_h = true
#		velocity.x -= SPEED * delta
	elif Input.is_action_pressed("move_right"):
#		global_position.x += SPEED * delta
		$FsSlime.flip_h = false
#		velocity.x += SPEED * delta
	else:
		$FsSlime.play("default")

	move_and_slide()
	
	if Global.hp <= 0:
		is_r_dying = true
		
		if is_r_dying:
			is_r_dying = false
			get_tree().change_scene_to_file("res://black_2_0.tscn")
	
func update_health():
	@warning_ignore("shadowed_variable")
	var health = Global.hp 
	var healthbar = $HealthBar
	healthbar.value = health

@warning_ignore("unused_parameter")
func _on_wall_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if is_dying:
		is_dying = false
		Global.hp = Global.hp - 1
		get_tree().change_scene_to_file("res://flappy_slime.tscn")


@warning_ignore("unused_parameter")
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if is_dying:
		is_dying = false
		Global.hp = Global.hp - 1
		get_tree().change_scene_to_file("res://flappy_slime.tscn")


@warning_ignore("unused_parameter")
func _on_win_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_tree().change_scene_to_file("res://flappy_slime_2.tscn")
