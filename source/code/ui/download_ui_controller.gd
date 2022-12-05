extends Control

onready var canvas = get_tree().get_current_scene().get_node("Canvas")

func _on_Close_pressed():
	visible = false
	canvas.set("is_mouse_over_ui", false)
