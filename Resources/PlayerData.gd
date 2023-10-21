extends Resource
class_name PlayerData

signal touched_slime

var player_position_x: float = 0
var player_position_y: float= 0

@export var player: CharacterBody2D
@export var slime: CharacterBody2D

func change_position(position):
	player_position_x = player.global_position.x
	player_position_y = player.global_position.y
