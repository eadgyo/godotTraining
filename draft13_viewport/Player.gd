extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_key_pressed(KEY_U):
		_screenshot()

func _screenshot():
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	img.save_png("screenshot.png")
