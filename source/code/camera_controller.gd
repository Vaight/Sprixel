extends Camera2D

var is_dragging = false
var drag_origin = Vector2(0,0)
var zoom_pos = Vector2(0,0)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				# zoom_pos = get_global_mouse_position()
				zoom.x -= 0.01
				zoom.y -= 0.01
			if event.button_index == BUTTON_WHEEL_DOWN:
				# zoom_pos = get_global_mouse_position()
				zoom.x += 0.01
				zoom.y += 0.01
		if event.button_index == BUTTON_MIDDLE:
			if event.is_pressed():
				drag_origin = get_global_mouse_position()
			print(drag_origin)
			is_dragging = event.pressed
	if event is InputEventMouseMotion:
		if is_dragging:
			position = -(get_local_mouse_position()-drag_origin)
