extends Sprite2D

var get_star = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_star = true
	if get_star:
		get_star = false
		Global.star = Global.star + 1
		print(Global.star)
		queue_free()
