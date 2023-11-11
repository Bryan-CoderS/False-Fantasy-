extends Node2D

var is_dying = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_kill_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	is_dying = true
	if is_dying:
		Global.hp = Global.hp - 1
		get_tree().change_scene_to_file("res://scene_3.tscn")
