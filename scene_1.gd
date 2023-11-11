extends Node2D
const Slime_blue = preload("res://slime_blue.tscn")
const battle_scene = preload("res://battle.tscn")
@export var player = CharacterBody2D
@export var slime = CharacterBody2D
var player_touched = false
var is_dying = false
# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.show_example_dialogue_balloon(load("res://Begining.dialogue"))
	await DialogueManager.dialogue_ended
	$Oceanbg.play("default")
	
	if Global.welcome_a == false:
		$Player/Trophy.show()
		$AudioStreamPlayer2D2.play()
		Global.welcome_a = true
		await get_tree().create_timer(2.0).timeout
		$Player/Trophy.hide()
		
#	if player_touched == true:
##		load_position()
#
#		for child in get_children():
#			if child is Slime_blue:
#				child.touched_slime.connect(_on_slime_touched)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if player_touched == true:
#		load_position()
#		change_scene()
#
#
#func _on_slime_touched(player, slime):
#	change_scene()
#	load_position()
#
#func spawn_slime():
#	var slime_scene = preload("res://slime_blue.tscn")
#	var new_slime = slime_scene.instantiate()
#	new_slime.set_name("Slime" + str(get_child_count()))
#	add_child(new_slime)
#
#func load_position():
#	look_at(player.global_position)
#
#func change_scene():
#	get_tree().change_scene_to_file("res://battle.tscn")
#	print("change_scene")
	
	
	
	
	
	


func _on_kill_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	is_dying = true
	if is_dying:
		Global.hp = Global.hp - 1
		get_tree().change_scene_to_file("res://scene_1.tscn")
