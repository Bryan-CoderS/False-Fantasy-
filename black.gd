extends Node2D


func _ready():
	await get_tree().create_timer(3.0).timeout	
	get_tree().change_scene_to_file("res://bad_end.tscn")
	
func _process(delta):
	if Global.bad_end == false:
		Global.bad_end = true
		$Trophy.show()
		$AudioStreamPlayer2D2.play()
		await get_tree().create_timer(2.0).timeout
		$Trophy.hide()
