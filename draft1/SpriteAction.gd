extends Sprite

var action_move_up = InputEventAction.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for action in InputMap.get_actions():
		var list = InputMap.get_action_list(action)
	action_move_up.action = "move_up"
	action_move_up.pressed = true


func auto_move():
	Input.parse_input_event(action_move_up)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event.is_action("move_up"):
		if event.pressed:
			print("start walking")
		else:
			print("stop walking")
	elif Input.is_key_pressed(KEY_LEFT):
		auto_move()
	
func _process(delta):
	if Input.is_action_pressed("move_up"):
		print("walk")
