extends CharacterBody2D
class_name Boss_slime

signal touched_slime

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_touched = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	
	if velocity.length() > 0:
		$Boss.play("idle")
	
	if velocity.x > 0:
		$Boss.flip_h = false
	else:
		$Boss.flip_h = true

		



func _on_area_2d_body_entered(body):
	print("Slime")
	DialogueManager.show_example_dialogue_balloon(load("res://boss.dialogue"))
	await DialogueManager.dialogue_ended
	get_tree().change_scene_to_file("res://boss_fight_1.tscn")
