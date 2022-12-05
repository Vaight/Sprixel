extends Sprite

var canvas_size:Vector2 = Vector2(16,16)
var canvas_image = Image.new()
var canvas_image_texture = ImageTexture.new()
onready var cursor = $Cursor
onready var background = $Background
var is_mouse_over_ui = false
var is_dragging = false
onready var root = get_tree().get_current_scene()
onready var color_selector = root.get_node("CanvasLayer/ColorSelector")
var current_color = Color(0,0,0,1)
var current_offsets = [Vector2(0,0)]

func _ready():
	_bind_all_ui()
	_create_canvas(canvas_size)
	is_mouse_over_ui = false
	background.modulate = Color(0.7, 0.7, 0.7, 1)
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
	is_mouse_over_ui = false

func _update_canvas(pixel:Vector2, color:Color):
	if pixel.x >= 0 && pixel.x <= canvas_size.x:
		if pixel.y >= 0 && pixel.y <= canvas_size.y:
			canvas_image.lock()
#			canvas_image.set_pixel(pixel.x, pixel.y, color)
			for i in current_offsets:
				canvas_image.set_pixel(pixel.x + i.x, pixel.y + i.y, color)
			canvas_image.unlock()
			canvas_image_texture.create_from_image(canvas_image,1)
			texture = canvas_image_texture

func _save_canvas_in_downloads(name:String):
	canvas_image.save_png(OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS) + "/" + name + ".png")

func _wait(seconds:float): # yield(_wait(5), "completed")
	var timer = get_tree().create_timer(seconds)
	yield(timer, "timeout")
	return

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			var coords = Vector2(floor(get_global_mouse_position().x)+0.5, floor(get_global_mouse_position().y)+0.5)
			coords = Vector2(coords.x+(canvas_size.x/2), coords.y+(canvas_size.y/2))
			if not is_mouse_over_ui:
				_update_canvas(coords, current_color)
			is_dragging = event.pressed
	if event is InputEventMouseMotion:
		cursor.position = Vector2(
			floor(get_global_mouse_position().x)+0.5,
			floor(get_global_mouse_position().y)+0.5
		)
		if is_dragging:
			var coords = Vector2(
				cursor.position.x+(canvas_size.x/2),
				cursor.position.y+(canvas_size.y/2)
			)
			if not is_mouse_over_ui:
				_update_canvas(coords, current_color) # Color(root.get_node("CanvasLayer/Color").text)

func _get_descendants(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = _get_descendants(child,arr)
	return arr

func _bind_all_ui():
	var ui_layer = root.get_node("CanvasLayer")
	for i in get_tree().get_nodes_in_group("ui_disables_drawing"):
		i.connect("mouse_entered", self, "_mouse_enter_ui_object")
		i.connect("mouse_exited", self, "_mouse_exit_ui_object")
		if i.name == "ExportImage":
			i.connect("pressed", self, "_open_downloads_gui")
		print(i)

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
	
func _on_ColorSelector_color_changed(color):
	current_color = color

func _on_BrushMenu_brush_change(offsets):
	current_offsets = offsets
	print(current_offsets)
	is_mouse_over_ui = false
