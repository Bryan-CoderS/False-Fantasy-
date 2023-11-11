extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("scene1")
	await get_tree().create_timer(7.0).timeout
	$AnimatedSprite2D.play("scene2")
	DialogueManager.show_example_dialogue_balloon(load("res://cutscene3.dialogue"))
	await DialogueManager.dialogue_ended
	$AnimationPlayer.play("shake")
	$AnimationPlayer.play("shake")
	$AnimatedSprite2D.play("scene3")
	await get_tree().create_timer(2.0).timeout
	$AnimatedSprite2D2.show()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://boss_fight_1.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
