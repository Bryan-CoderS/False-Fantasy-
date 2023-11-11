extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.hp = 10
	$AnimatedSprite2D.play("end")
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_file("res://main_menu.tscn")

