extends CharacterBody2D

var bullet = preload("res://maze_slime_bullet.tscn")
var can_shoot = false

func _ready():
	$Timer.start(2.0)
	
func _physics_process(delta):
	if can_shoot:
		shoot()
		$Timer.start(randi() %5 + 1)
		
		can_shoot = false

func _on_timer_timeout():
	can_shoot = true
	$Timer.stop()
	
func shoot():
	$AnimatedSprite2D.play("shoot")
	var inst = bullet.instantiate()
	# getting the parent node to add bullet ( main scene in this case )
	get_parent().add_child(inst)
	# setting position of the bullet.
	inst.global_position = $bullet_pos.global_position
