extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.translate(Vector3(10*delta, 0, 0))


func _on_AudioStreamPlayer3D_finished():
	print("play")
	$AudioStreamPlayer3D.play(0)
