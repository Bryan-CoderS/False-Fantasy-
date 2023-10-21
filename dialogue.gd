extends Node2D

@export var Scene_1: PackedScene
var dialogue_play = false

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1.0).timeout
	DialogueManager.show_example_dialogue_balloon(load("res://dialog.dialogue"), "scene_1")
	await DialogueManager.dialogue_ended
	get_tree().change_scene_to_file(Scene_1.resource_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass	

func _on_next_button_button_up():
	get_tree().change_scene_to_file(Scene_1.resource_path)

