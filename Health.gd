extends Label

func _ready():
	self.text = str("HP: ") + str(get_parent().health)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = str("HP: ") + str(get_parent().health)
