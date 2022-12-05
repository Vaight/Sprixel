extends Panel

var offset_values = [] # all the offset pixels to draw with the cursor
onready var canvas = get_tree().get_current_scene().get_node("Canvas")#.get_script()
signal brush_change(offsets)

func _on_Pixel_pressed():
	offset_values.clear()
	offset_values.append(Vector2( 0, 0))
	emit_signal("brush_change", offset_values)
	_close_window()
func _on_2x2_pressed():
	offset_values.clear()
	offset_values.append(Vector2( 0, 0))
	offset_values.append(Vector2( 1, 0))
	offset_values.append(Vector2( 0, 1))
	offset_values.append(Vector2( 1, 1))
	emit_signal("brush_change", offset_values)
	_close_window()
func _on_3x3_pressed():
	offset_values.clear()
	offset_values.append(Vector2( 0, 0))
	offset_values.append(Vector2(-1, 0))
	offset_values.append(Vector2( 1, 0))
	offset_values.append(Vector2( 0, 1))
	offset_values.append(Vector2( 0,-1))
	offset_values.append(Vector2(-1, 1))
	offset_values.append(Vector2( 1, 1))
	offset_values.append(Vector2(-1,-1))
	offset_values.append(Vector2( 1,-1))
	emit_signal("brush_change", offset_values)
	_close_window()
func _on_4x4_pressed():
	offset_values.clear()
	offset_values.append(Vector2(0,0))
	emit_signal("brush_change", offset_values)
	_close_window()

func _on_Close_pressed():
	_close_window()
func _close_window():
	visible = false
	canvas.set("is_mouse_over_ui", false)
func _open_popup():
	visible = true
