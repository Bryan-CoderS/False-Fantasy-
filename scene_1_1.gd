extends Node2D

var is_dying = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Oceanbg.play("default")

func _on_kill_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	is_dying = true
	if is_dying:
		Global.hp = Global.hp - 1
		get_tree().change_scene_to_file("res://scene_1_1.tscn")
