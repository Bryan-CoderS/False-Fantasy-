extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Cutscene.play("cutscene")
	await get_tree().create_timer(18.0).timeout
	get_tree().change_scene_to_file("res://scene_2.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
