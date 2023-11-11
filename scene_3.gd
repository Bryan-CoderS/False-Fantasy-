extends Node2D

var is_dying = false
# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.show_example_dialogue_balloon(load("res://scene_3.dialogue"))
	await DialogueManager.dialogue_ended
	
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
		Global.is_dying = true
		get_tree().change_scene_to_file("res://scene_3.tscn")
