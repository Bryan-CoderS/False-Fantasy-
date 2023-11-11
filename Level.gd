extends AnimatedSprite2D

var enter = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	enter = true
	if enter:
		enter = false
		DialogueManager.show_example_dialogue_balloon(load("res://level.dialogue"))
		await DialogueManager.dialogue_ended
		get_tree().change_scene_to_file("res://flappy_slime.tscn")
