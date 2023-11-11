extends Node2D

@export var dialogue_scene: PackedScene

func _on_start_button_button_up():
	Global.hp = 10
	get_tree().change_scene_to_file(dialogue_scene.resource_path)

func _on_exit_button_button_up():
	print("quit")
	get_tree().quit()
	


func _on_achievement_button_up():
	get_tree().change_scene_to_file("res://achievement_page.tscn")
