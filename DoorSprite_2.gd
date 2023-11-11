extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_area_2d_body_entered(body):
		if body.name == "Player":
			if Global.star == 20:
				print("Complete")
				await get_tree().create_timer(0.5).timeout
				print("NEXT SCENE")
				get_tree().change_scene_to_file("res://maze_1.tscn")
			else:
				DialogueManager.show_example_dialogue_balloon(load("res://20star.dialogue"))
				await DialogueManager.dialogue_ended
				Global.star = 0
				get_tree().change_scene_to_file("res://scene_3.tscn")
				
