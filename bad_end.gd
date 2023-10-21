extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("bad_end")
	await get_tree().create_timer(6.0).timeout
	$AnimatedSprite2D.play("black")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://main_menu.tscn")
