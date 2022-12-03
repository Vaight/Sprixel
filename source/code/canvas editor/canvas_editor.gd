extends Sprite

var canvas_size:Vector2 = Vector2(16,16)
var canvas_image = Image.new()
var canvas_image_texture = ImageTexture.new()
onready var cursor = $Cursor
onready var background = $Background
var is_mouse_over_ui = false
onready var root = get_tree().get_current_scene()

func _ready():
	_bind_all_ui()
	_create_canvas(canvas_size)
	is_mouse_over_ui = false
	yield(_wait(5), "completed")
	print("WOOHOO")

func _process(delta):
	pass

func _create_canvas(size:Vector2):
	canvas_size = size
	canvas_image.create(size.x, size.y, false, Image.FORMAT_RGBA8)
	canvas_image.fill(Color(1,1,1,0))
	canvas_image_texture.create_from_image(canvas_image,1)
	texture = canvas_image_texture
	background.region_rect = Rect2(0,0,size.x, size.y)

func _update_canvas(pixel:Vector2, color:Color):
	if pixel.x >= 0 && pixel.x <= canvas_size.x:
		if pixel.y >= 0 && pixel.y <= canvas_size.y:
			canvas_image.lock()
			canvas_image.set_pixel(pixel.x, pixel.y, color)
			canvas_image.unlock()
			canvas_image_texture.create_from_image(canvas_image,1)
			texture = canvas_image_texture
		else:
			print(str(pixel, " Is not a valid pixel on canvas ", canvas_size))
	else:
		print(str(pixel, " Is not a valid pixel on canvas ", canvas_size))

func _save_canvas_in_downloads(name:String):
	canvas_image.save_png(OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS) + "/" + name + ".png")

func _wait(seconds:float): # yield(_wait(5), "completed")
	var timer = get_tree().create_timer(seconds)
	yield(timer, "timeout")
	return

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if not is_mouse_over_ui:
				var coords = get_global_mouse_position()
				coords = Vector2(floor(coords.x)+(canvas_size.x/2), floor(coords.y)+(canvas_size.y/2))
				_update_canvas(coords, Color(root.get_node("CanvasLayer/Color").text))
	if event is InputEventMouseMotion:
		cursor.position = Vector2(floor(get_global_mouse_position().x)+0.5, floor(get_global_mouse_position().y)+0.5)

func _get_descendants(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = _get_descendants(child,arr)
	return arr

func _bind_all_ui():
	var ui_layer = root.get_node("CanvasLayer")
	for i in _get_descendants(ui_layer):
		i.connect("mouse_entered", self, "_mouse_enter_ui_object")
		i.connect("mouse_exited", self, "_mouse_exit_ui_object")
		if i.name == "ExportImage":
			i.connect("pressed", self, "_open_downloads_gui")

func _mouse_enter_ui_object():
	is_mouse_over_ui = true
func _mouse_exit_ui_object():
	is_mouse_over_ui = false
func _open_downloads_gui():
	root.get_node("CanvasLayer/Download").visible = true

func _on_Confirm_pressed(): # confirming the save of a file to downloads
	if root.get_node("CanvasLayer/Download/Confirm/NameEdit").text:
		_save_canvas_in_downloads(root.get_node("CanvasLayer/Download/Confirm/NameEdit").text)
	else:
		_save_canvas_in_downloads("Untitled Image")
	root.get_node("CanvasLayer/Download").visible = false


func _on_NewCanvasPopup_create_new_canvas(size):
	_create_canvas(size)
