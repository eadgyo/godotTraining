extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	$Camera.set_translation($Cube.get_translation() + Vector3(0, 25, 25))
	$Camera.set_rotation(Vector3(-45, 0, 0))
