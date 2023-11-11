extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(3.0).timeout	
	get_tree().change_scene_to_file("res://game_over.tscn")

func _process(delta):
	if Global.bad_end == false:
		Global.bad_end = true
		$Trophy.show()
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(2.0).timeout
		$Trophy.hide()

