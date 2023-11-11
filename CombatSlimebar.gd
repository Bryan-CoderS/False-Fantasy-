extends CharacterBody2D

const SPEED = 500.0

var left = false
var right = false
var attack = false
var miss = false


func _physics_process(delta):
	if left == true:
		global_position.x += SPEED * delta
	elif right == true:
		global_position.x -= SPEED * delta
	else:
		global_position.x += SPEED * delta
		
	if Input.is_action_just_pressed("Stop"):
		if attack == true:
			Global.apple = true
		elif miss == true:
			Global.miss = true
		else:
			pass
		set_physics_process(false)
		await get_tree().create_timer(3.0).timeout
		set_physics_process(true)


func _on_left_wall_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	left = true
	right = false


func _on_right_wall_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	right = true
	left = false


func _on_apple_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	attack = true


func _on_apple_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	attack = false
	


func _on_miss_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	miss = true
	
func _on_miss_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	miss = false
