extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func explode():
	set_explosiveness_ratio(1.0)
	set_one_shot(true)
	set_emitting(true)
