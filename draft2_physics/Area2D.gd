extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func area_exited_func(body_id: int, body: Node, body_shape: int, local_shape: int):
	print("Area left")

func area_entered_func(body_id: int, body: Node, body_shape: int, local_shape: int):
	print("Area entered")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_shape_entered", self, "area_entered_func")
	self.connect("body_shape_exited", self, "area_exited_func")
	
	print("ending ready")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
