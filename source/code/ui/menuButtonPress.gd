extends Node

# onready components
onready var display_window = self.get_parent().get_parent().get_node("window_border")

# values
var toggle1 = false
var toggle2 = false
var window_size_tmp = Vector2(640, 480)
var buttons_to_move = []

func _ready():
	print(display_window)
	for _i in self.get_parent().get_children():
		if not buttons_to_move.has(_i):
			if not _i is MenuButton:
				buttons_to_move.append(_i)
func _on_Close_pressed():
	get_tree().quit()

func _on_Minimize_pressed():
	OS.window_minimized = true

func _on_Help_pressed():
	toggle2 = !toggle2
	if toggle2 == true:
		self.get_parent().get_parent().get_node("credits_popup").visible = true
	else:
		self.get_parent().get_parent().get_node("credits_popup").visible = false

func _on_Maximize_pressed():
	toggle1 = !toggle1
	if toggle1 == true:
		window_size_tmp = Vector2(1280, 960)
		OS.window_size = window_size_tmp
		OS.window_position -= Vector2(320,140)
		display_window.rect_size = window_size_tmp/2
		for _i in buttons_to_move:
			_i.rect_position.x = _i.rect_position.x+640
	else:
		window_size_tmp = Vector2(640, 480)
		OS.window_size = window_size_tmp
		OS.window_position += Vector2(320,140)
		display_window.rect_size = window_size_tmp/2
		for _i in buttons_to_move:
			_i.rect_position.x = _i.rect_position.x-640
