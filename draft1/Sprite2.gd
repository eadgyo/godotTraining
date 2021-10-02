extends Sprite
export var SPEED = 500
var device_index = 0



export var movement_speed = 50
var input_direction = 0

func _process(delta):
	position.x += input_direction * movement_speed * delta
	
	var node = get_node("A/B")
	$"A/B".position.x += input_direction * movement_speed * delta * -2
	var node2 = node.get_node("..")
	node2.position.x += input_direction * movement_speed * delta * -10
	#node2.call_me_maybe()

func _input(event):
	if event.is_action_pressed("ui_left"):
		input_direction = -1
	elif event.is_action_pressed("ui_right"):
		input_direction = 1
		
		
	if event.is_action_released("ui_left"):
		input_direction = 0
	elif event.is_action_released("ui_right"):
		input_direction = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
