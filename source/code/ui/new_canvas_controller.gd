extends Control

onready var canvas = get_tree().get_current_scene().get_node("Canvas")
var canvas_script = load("res://code/canvas editor/canvas_editor.gd")

signal create_new_canvas(size)

func _ready():
	pass

func _on_Confirm_pressed():
	var size = Vector2($Confirm/XPixels.text.to_int(), $Confirm/YPixels.text.to_int())
	emit_signal("create_new_canvas", size)
	visible = false

func _on_Close_pressed():
	visible = false
func _on_NewCanvas_pressed():
	visible = true
