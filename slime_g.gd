extends CharacterBody2D
class_name Slime_g

signal touched_slime(pos)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_touched = false


func _process(delta):
	pass
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	
	if velocity.length() > 0:
		$SlimeGSprite.play("idle")
	
	if velocity.x > 0:
		$SlimeGSprite.flip_h = false
	else:
		$SlimeGSprite.flip_h = true

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("Slime")
	DialogueManager.show_example_dialogue_balloon(load("res://slime.dialogue"))
	await DialogueManager.dialogue_ended
	player_touched = true
	emit_signal("touched_slime")
	get_tree().change_scene_to_file("res://battle_3.tscn")
