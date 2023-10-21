extends Node2D

const AL = preload("res://move_arrow_left.tscn")
const AU = preload("res://move_arrow_up.tscn")
const AR = preload("res://move_arrow_right.tscn")

var random = 0
var RNG = RandomNumberGenerator.new()
var bpm = 115

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

var spawn_1_beat = 0
var spawn_2_beat = 0
var spawn_3_beat = 1
var spawn_4_beat = 0



func _ready():
	randomize()
	$Conductor.play_with_beat_offset(8)

func _process(delta):
	$Score/Label.text = str(Global.score)

func _on_Conductor_measure(position):
	if position == 1:
		_spawn_notes(spawn_1_beat)
	elif position == 2:
		_spawn_notes(spawn_2_beat)
	elif position == 3:
		_spawn_notes(spawn_3_beat)
	elif position == 4:
		_spawn_notes(spawn_4_beat)

func _on_Conductor_beat(position):
	song_position_in_beats = position
	if song_position_in_beats > 36:
		spawn_1_beat = 1
		spawn_2_beat = 1
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 98:
		spawn_1_beat = 2
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 132:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 0
		spawn_4_beat = 2
	if song_position_in_beats > 162:
		spawn_1_beat = 2
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 1
	if song_position_in_beats > 194:
		spawn_1_beat = 2
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 228:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 258:
		spawn_1_beat = 1
		spawn_2_beat = 2
		spawn_3_beat = 1
		spawn_4_beat = 2
	if song_position_in_beats > 288:
		spawn_1_beat = 0
		spawn_2_beat = 2
		spawn_3_beat = 0
		spawn_4_beat = 2
	if song_position_in_beats > 322:
		spawn_1_beat = 3
		spawn_2_beat = 2
		spawn_3_beat = 2
		spawn_4_beat = 1
	if song_position_in_beats > 388:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	if song_position_in_beats > 396:
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	if song_position_in_beats > 404:
		print("null")
		pass


func _spawn_notes(to_spawn):
	RNG.randomize()
	var random_int = RNG.randi_range(0,3)
	random = random_int

	if random == 1:
		var al = AL.instantiate()
		get_parent().add_child(al)
		al.global_position = $Create/Marker2D_AL.position

	if random == 2:
		var au = AU.instantiate()
		get_parent().add_child(au)
		au.global_position = $Create/Marker2D_AU.position

	if random == 3:
		var ar = AR.instantiate()
		get_parent().add_child(ar)
		ar.global_position = $Create/Marker2D_AR.position
	
#func _on_timer_timeout():
#	$Timer.start()
#	RNG.randomize()
#	var random_int = RNG.randi_range(0,3)
#	random = random_int
#
#	if random == 1:
#		var al = AL.instantiate()
#		get_parent().add_child(al)
#		al.global_position = $Create/Marker2D_AL.position
#
#	if random == 2:
#		var au = AU.instantiate()
#		get_parent().add_child(au)
#		au.global_position = $Create/Marker2D_AU.position
#
#	if random == 3:
#		var ar = AR.instantiate()
#		get_parent().add_child(ar)
#		ar.global_position = $Create/Marker2D_AR.position
