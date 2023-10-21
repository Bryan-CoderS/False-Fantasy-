extends Node

var current_health = 100
var max_health = 100
var damage = 20
var level = 1

func _process(delta):
	level_up()

func level_up():
	if level == 2:
		damage = 30
	elif level == 3:
		damage = 40
	else:
		pass
