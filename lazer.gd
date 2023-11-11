extends Sprite2D

var is_dying = false

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		is_dying = true
		if is_dying:
			is_dying = false
			Global.hp = Global.hp - 1
			get_tree().change_scene_to_file("res://maze_1.tscn")
