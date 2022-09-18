extends Sprite

func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			self.modulate = Color(0,0,0,1)
