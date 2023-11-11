extends Node2D
#const slime_scene = preload("res://egg_slime.tscn")
#const battle_scene = preload("res://battle_2.tscn")
#@export var player = CharacterBody2D
#@export var slime: PackedScene
#var player_touched = false
var is_dying = false
## Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	player_touched = true
#	load_position()
#
#
#	for child in get_children():
#		if child is Egg_slime:
#			connect("touched_slime", _on_slime_touched())
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	load_position()
#
#func _on_slime_touched():
#	load_position()
#	var timer = Timer.new()
#	timer.wait_time = 2.0
#	timer.one_shot = true
#	connect("timeout", change_scene())
#	add_child(timer)
#	timer.start()
#
#
#func spawn_slime():
#	var slime_scene = preload("res://egg_slime.tscn")
#	var new_slime = slime_scene.instance()
#	new_slime.set_name("Slime" + str(get_child_count()))
#	add_child(new_slime)
#
#func load_position():
#	look_at(player.global_position)
#
#func change_scene():
#	get_tree().change_scene_to_file("res://battle_2.tscn")
#


func _on_kill_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	is_dying = true
	if is_dying:
		Global.hp = Global.hp - 1
		get_tree().change_scene_to_file("res://scene_2.tscn")
