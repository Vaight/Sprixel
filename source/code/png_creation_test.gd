extends Node
func _ready():
	var img = Image.new()
	img.create(16,16,false,Image.FORMAT_RGBA8)
	img.fill(Color.white)
	img.save_png("Test.png")
