extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	DialogueManager.show_example_dialogue_balloon(load("res://level.dialogue"))
	await DialogueManager.dialogue_ended
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://puzzle_2.tscn")
