extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -400.0
signal player_hit(value)

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _animated_sprite = $MainCharacterSprite
var health = Global.hp
var is_dying = false

func _ready():
	update_health()

func _process(delta):
	update_health()
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("jump") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
		
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
	elif Input.is_action_pressed("move_up"):
		global_position.y -= SPEED * delta
	elif Input.is_action_pressed("move_down"):
		global_position.y += SPEED * delta
	else:
		_animated_sprite.play("stand")
	
	move_and_slide()
	
	if Global.hp <= 0:
		is_dying = true
		
		if is_dying:
			is_dying = false
			get_tree().change_scene_to_file("res://black_2_0.tscn")
		
	

func update_health():
	var health = Global.hp
	var healthbar = $HealthBar
	healthbar.value = health
	
func take_damage():
	health = health - 1
	Global.hp = Global.hp - 1
	emit_signal("player_hit",health)
