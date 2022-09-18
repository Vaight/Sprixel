extends MenuButton

var popup
export var options_list = ["1", "2", "3"]

func _ready():
	popup = get_popup()
	popup.theme = load("res://themes/dropdown.tres")
	for i in range(0, options_list.size()):
		popup.add_item(" " + options_list[i] + " ")
	popup.connect("id_pressed", self, "_on_item_pressed")

func _on_item_pressed(ID):
	print(popup.get_item_text(ID), " option pressed")
	if popup.get_item_text(ID) == " new project ":
		var _popup = get_parent().get_parent().get_node("new_project_popup")
		if _popup.visible == false:
			_popup.visible = true
