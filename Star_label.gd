extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = str("Star: ") + str(Global.star)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = str("Star: ") + str(Global.star)
