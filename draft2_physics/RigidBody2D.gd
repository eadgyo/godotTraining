extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var space_state: Physics2DDirectSpaceState = get_world_2d().get_direct_space_state()
	var dic : Dictionary = space_state.intersect_ray(position, position + Vector2(0, 50),  [  ], 0x7FFFFFFF, true, true)
	
	#print(dic)
	#print("collision size " + str(dic.size()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
