extends Viewport


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func host_game(port):
	var viewport = get_node("Viewport")
	# 2D
	var sprite = get_node("Srpite")
	sprite.texture = viewport.get_texture()
	# 3D
	var mesh = get_node("Mesh")
	mesh.material_ovrride.albedo_texture = viewport.get_texture() 
