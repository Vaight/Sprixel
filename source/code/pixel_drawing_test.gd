extends Node2D

export var x_size = 16
export var y_size = 16

var tool_type = "none"
var my_array_init = Vector2(0,0)
var stored_pixels = [my_array_init]
var root = self
onready var cursor = $Sprite

func _ready():
	# _create_png(Vector2(16,16), "test2.png")
	stored_pixels.clear()
	root.update()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var coords = get_global_mouse_position()
			coords = Vector2(floor(coords.x), floor(coords.y))
			stored_pixels.append(coords)
			root.update()
	if event is InputEventMouseMotion:
		cursor.position = Vector2(floor(get_global_mouse_position().x)+0.5, floor(get_global_mouse_position().y)+0.5)

func _draw():
	for _y in range(0, y_size):
		for _x in range(0, x_size):
			draw_rect(Rect2(_x - x_size/2, _y - y_size/2, 1, 1), Color.gray, true)
	
	for _i in range(0, stored_pixels.size()):
		var coords = stored_pixels[_i]
		# print(coords)
		draw_rect(Rect2(coords.x, coords.y, 1, 1), Color.black, true)
	
	print(stored_pixels.size())

func _create_png(size : Vector2, name : String):
	var img = Image.new()
	img.create(size.x,size.y,false,Image.FORMAT_RGBA8)
	img.fill(Color.white)
	for _i in range(0, stored_pixels.size()):
		img.lock()
		img.set_pixel(stored_pixels[_i].x+x_size/2, stored_pixels[_i].y+y_size/2, Color.black)
		print(stored_pixels[_i])
	img.unlock()
	img.save_png(OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS) + name)


func _on_Button_pressed():
	_create_png(Vector2(x_size,y_size), "/test2.png")
