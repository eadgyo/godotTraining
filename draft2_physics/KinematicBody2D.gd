extends KinematicBody2D

export (float) var speed = 100.0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var direction = Vector2()
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
		
	# Normalize the movement vector and modulate by the speed
	var movement = direction.normalized() * speed
	
	# Move the body based on the calculated speed and direction
	move_and_slide(movement)
	
	#print("ray cast is colling " + str($RayCast2D.is_colliding()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
