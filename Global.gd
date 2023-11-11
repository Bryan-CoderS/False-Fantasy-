extends Node

var hp = 10
var is_dying = false
var star = 0
var apple = false
var miss = false
var stop = false

func _process(delta):
	if is_dying:
		is_dying = false
		star = 0
