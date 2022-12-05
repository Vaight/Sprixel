extends Control

onready var canvas = get_tree().get_current_scene().get_node("Canvas")

signal create_new_canvas(size)

func _ready():
	pass

func _on_Confirm_pressed():
	var size = Vector2($Confirm/XPixels.text.to_int(), $Confirm/YPixels.text.to_int())
	emit_signal("create_new_canvas", size)
	_close_window()

func _on_Close_pressed():
	_close_window()
func _on_NewCanvas_pressed():
	visible = true

func _close_window():
	visible = false
	canvas.set("is_mouse_over_ui", false)
