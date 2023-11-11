extends Area2D

@onready var animp = $AnimationPlayer
var sensor = 0


func _process(delta):
	if sensor == 1:
		if Input.is_action_just_pressed("ui_right"):
			animp.play("Good")
			Global.score += 10
			
	if sensor == 0:
		if Input.is_action_just_pressed("ui_right"):
			animp.play("Bad")
			Global.score -= 10


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = 1
	Global.sensor_AR = 1


func _on_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = 0
	Global.sensor_AR = 0
