extends Node

func _ready():
	var img = get_parent().get_viewport().get_texture().get_data()
	# Convert Image to ImageTexture.
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	# Set Sprite Texture.
	self.texture = tex
