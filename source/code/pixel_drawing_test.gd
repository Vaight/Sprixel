extends Node2D

export var x_size = 16
export var y_size = 16

var tool_type = "none"
var my_array_init = Vector2(0,0)
var stored_pixels = [my_array_init]
var root = self

func _ready():
	stored_pixels.clear()
	root.update()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var coords = root.get_global_mouse_position()
			coords = Vector2(round(coords.x), round(coords.y))
			stored_pixels.append(coords)
			root.update()

func _draw():
	for _y in range(0, y_size):
		for _x in range(0, x_size):
			draw_rect(Rect2(_x - x_size/2, _y - y_size/2, 1, 1), Color.white, true)
	
	for _i in range(0, stored_pixels.size()):
		var coords = stored_pixels[_i]
		print(coords)
		draw_rect(Rect2(coords.x, coords.y, 1, 1), Color.black, true)
	
	draw_rect(Rect2(350, 241, 1, 1), Color.black, true)
