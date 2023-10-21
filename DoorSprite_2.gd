extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	print("Complete")
	await get_tree().create_timer(2.0).timeout
	print("NEXT SCENE")
	get_tree().change_scene_to_file("res://maze_1.tscn")
