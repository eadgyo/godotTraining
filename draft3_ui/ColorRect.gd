extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _gui_input(event):
	if event is InputEventMouse:
		var v = event.position / rect_size
		color = Color(v.x, v.y, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
