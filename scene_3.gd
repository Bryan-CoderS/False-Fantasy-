extends Node2D

var is_dying = false
# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.show_example_dialogue_balloon(load("res://scene_3.dialogue"))
	await DialogueManager.dialogue_ended

func _on_kill_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	is_dying = true
	if is_dying:
		Global.hp = Global.hp - 1
		Global.is_dying = true
		get_tree().change_scene_to_file("res://scene_3.tscn")
