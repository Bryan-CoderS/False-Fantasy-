extends CharacterBody2D
class_name Slime_blue

signal touched_slime(position)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_touched = false


func _process(delta):
	pass
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	
	if velocity.length() > 0:
		$SlimeBlueSprite.play("idle")
	
	if velocity.x > 0:
		$SlimeBlueSprite.flip_h = false
	else:
		$SlimeBlueSprite.flip_h = true
	



func _on_area_2d_2_body_entered(body):
	if body.name == "Player":
		print("Slime")
		DialogueManager.show_example_dialogue_balloon(load("res://slime.dialogue"))
		await DialogueManager.dialogue_ended
		player_touched = true
		touched_slime.emit(position)
		get_tree().change_scene_to_file("res://battle.tscn")
		queue_free()
			
