extends Area2D

var speed = 100
var sensor = 0


func _process(delta):

	position.y -= speed * delta
	
	if position.y < -50:
		queue_free()
		
	if sensor == 1:
		if Global.sensor_AL == 1:
			if Input.is_action_just_pressed("ui_left"):
				queue_free()
		pass


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = 1
	Global.sensor_AL = 1

func _on_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = 0
	Global.sensor_AL = 0
