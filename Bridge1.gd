extends TextureButton
var label: String
var dropped_on_target: bool = false
var correct_slot: String
var is_placed_correctly: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("DRAGGABLE")
	correct_slot = "BridgeDraft1"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_drag_data(position: Vector2):
	var slot = get_parent().get_name()
	
	var data = {}
	data["origin_node"] = self
	data["origin_slot"] = slot
	data["origin_texture_normal"] = texture_normal
	data["origin_texture_pressed"] = texture_pressed
	
	var dragPreview = preload("res://drag_preview.tscn").instance()
	dragPreview.texture = texture_normal
	add_child(dragPreview)
	
	return data
	
func _can_drop_data(position, data):
	var target_slot = get_parent().get_name()
	data["target_texture_normal"] = texture_normal
	data["target_texture_pressed"] = texture_pressed
	
	data["is_correct_slot"] = correct_slot == target_slot
	
	return true
	
func _drop_data(position, data):
	
	data["origin_node"].texture_normal = data["target_texture_normal"]
	data["origin_node"].texture_pressed = data["target_texture_pressed"]
	
	texture_normal = data["origin_texture_normal"]
	texture_pressed = data["origin_texture_pressed"]
	
	is_placed_correctly = data["is_correct_slot"]
