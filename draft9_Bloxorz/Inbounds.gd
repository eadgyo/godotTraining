extends Area

func _ont_Inbounds_area_exited(area):
	var body = area.get_parent()
	var parent = body.get_parent()
	if parent.won or parent.respawning:
		return
	body.gravity_scale = 1
	parent.lose()
	body.angular_velocity *= 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
