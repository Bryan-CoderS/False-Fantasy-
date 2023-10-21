extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.show_example_dialogue_balloon(load("res://scene_3.dialogue"))
	await DialogueManager.dialogue_ended


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
