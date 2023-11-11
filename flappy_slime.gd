extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$FsBg4/FsBg.play("default")
	$FsBg4/FsBg2.play("default")
	$FsBg4/FsBg3.play("default" )
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
