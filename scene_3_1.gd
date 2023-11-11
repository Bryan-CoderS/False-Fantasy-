extends Node2D

var is_dying = false
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.star == 20:
		if Global.full_star_a == false:
			Global.full_star_a = true
			$Player/Trophy.show()
			$AudioStreamPlayer2D2.play()
			await get_tree().create_timer(2.0).timeout
			$Player/Trophy.hide()


func _on_kill_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	is_dying = true
	if is_dying:
		Global.hp = Global.hp - 1
		get_tree().change_scene_to_file("res://scene_3.tscn")
