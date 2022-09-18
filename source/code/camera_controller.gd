extends Camera2D

var mouse_start_pos
var screen_start_position

var dragging = false
var zoom_pos = Vector2(0,0)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_pos = get_global_mouse_position()
				self.zoom.x -= 0.01
				self.zoom.y -= 0.01
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom_pos = get_global_mouse_position()
				self.zoom.x += 0.01
				self.zoom.y += 0.01
