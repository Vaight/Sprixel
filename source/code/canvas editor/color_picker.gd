extends Control

signal color_changed(color)
var background_box = load("res://themes/background_color_for_picker.tres")

func _ready():
	pass

func _on_Red_changed(val):
	emit_signal("color_changed", Color(
		$Red.value,
		$Green.value,
		$Blue.value,
		$Alpha.value
	))
func _on_Green_changed(val):
	emit_signal("color_changed", Color(
		$Red.value,
		$Green.value,
		$Blue.value,
		$Alpha.value
	))
func _on_Blue_changed(val):
	emit_signal("color_changed", Color(
		$Red.value,
		$Green.value,
		$Blue.value,
		$Alpha.value
	))
func _on_Alpha_changed(val):
	emit_signal("color_changed", Color(
		$Red.value,
		$Green.value,
		$Blue.value,
		$Alpha.value
	))
func _on_ColorSelector_color_changed(color):
	background_box.bg_color = color
	$Value.text = str($Red.value, "\n", $Green.value, "\n", $Blue.value, "\n", $Alpha.value)
