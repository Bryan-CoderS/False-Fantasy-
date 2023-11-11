extends Node

var hp = 10
var is_dying = false
var star = 0
var apple = false
var miss = false
var stop = false
var welcome_a = false
var escape_a = false
var one_shot = false
var full_star_a = false
var good_end = false
var defeat_boss = false
var bad_end = false
var noob = false
var full_heart = false

func _process(delta):
	if is_dying:
		is_dying = false
		star = 0
