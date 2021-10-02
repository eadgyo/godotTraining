extends Sprite
export var SPEED = 500

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _input(event):
	if event is InputEventKey && !event.echo:
		#Display the word "Echo"
		var is_echo = "Echo" if event.echo else ""
		var scancode = OS.get_scancode_string(event.scancode)
		
		if event.pressed:
			prints("Key pressed", scancode, is_echo)
		else:
			prints("Key released", scancode, is_echo)
			
	if event is InputEventJoypadButton:
		prints("Button: ", str(event.button_index))
	
	if event is InputEventMouseButton && event.pressed:
		prints("Button", event.button_index, "is pressed at", str(event.position))
	if event is InputEventMouseMotion:
		prints("Mouse moved to ", str(event.position))
		position = event.position
		
	if event is InputEventScreenTouch && event.pressed:
		prints("Screen touch at", str(event.position))
	if event is InputEventScreenDrag:
		prints("Screen drag at", str(event.position))
		event.position = event.position
	
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		print("Holding spressbar")
	
	var direction = Vector2(0, 0)
	if Input.is_key_pressed(KEY_UP):
		direction.y -= 1
	if Input.is_key_pressed(KEY_DOWN):
		direction.y += 1
	if Input.is_key_pressed(KEY_LEFT):
		direction.x -= 1
	if Input.is_key_pressed(KEY_RIGHT):
		direction.x += 1
	
	direction = direction.normalized()
	direction *= SPEED * delta
	translate(direction)
	
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
