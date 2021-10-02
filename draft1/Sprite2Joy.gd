extends Sprite
export var SPEED = 500
var device_index = 0

func joy_connect(index, connect):
	if connect:
		device_index = index

func _ready():
	Input.connect("joy_connection_changed", self, "joy_connect")
	
func _input(event):

	if event is InputEventJoypadButton:
		prints("Button: ", str(event.button_index))

func _process(delta):
	var direction = Vector2(0, 0)
	if Input.is_joy_button_pressed(device_index, JOY_DPAD_UP):
		direction.y -= 1
	if Input.is_joy_button_pressed(device_index, JOY_DPAD_DOWN):
		direction.y += 1
	if Input.is_joy_button_pressed(device_index, JOY_DPAD_LEFT):
		direction.x -= 1
	if Input.is_joy_button_pressed(device_index, JOY_DPAD_RIGHT):
		direction.x += 1
	direction = direction.normalized()
	direction *= SPEED * delta
	translate(direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
