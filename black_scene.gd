extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():	
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_file("res://end_scene.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.good_end == false:
		Global.good_end = true
		$Trophy.show()
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(2.0).timeout
		$Trophy.hide()
	
	if Global.hp == 10:
		if Global.full_heart == false:
			Global.full_heart = true
			$Trophy2.show()
			$AudioStreamPlayer2D.play()
			await get_tree().create_timer(2.0).timeout
			$Trophy2.hide()
