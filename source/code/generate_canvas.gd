extends Node

onready var pixel = preload("res://prefabs/pixel.tscn")

export var x_size_default = 32
export var y_size_default = 32

func _ready():
	generate(x_size_default, y_size_default)

func generate(x, y):
	var pixels = self.get_children()
	for _i in pixels:
		_i.queue_free()
	for _y in range(0, y):
		for _x in range(0, x):
			var px = pixel.instance()
			self.add_child(px)
			px.position = Vector2(
				x *-1 +x /2 +_x +0.5,
				y *-1 +y /2 +_y +0.5
			)


func _on_create_pressed(): # pressed when someone wants to make a new canvas with pixel values
	var _popup = get_parent().get_node("Window Border/new_project_popup")
	_popup.visible = false
	
	var x_pixels_tb = _popup.get_node("x_pixels")
	var y_pixels_tb = _popup.get_node("y_pixels")
	var x_px = x_pixels_tb.text.to_int()
	var y_px = y_pixels_tb.text.to_int()
	generate(x_px, y_px)
