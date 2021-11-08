extends Spatial

enum Direction { UP, DOWN, RIGHT, LEFT}
enum Orientation { PARRALEL, ORTHOGONAL }
enum RestPosition { STANDING, LYING }

var orientation = Orientation.PARRALEL
var rest_position = RestPosition.STANDING

var is_turning = false
var interpolation = 0
var rotation_direction = null
var won = false
var lost = false
var respawning = false

var right_shift = Vector3(-1, -0.5, 0)
var down_shift = Vector3(0, -0.5, 1)


func _input(event):
	if event.is_action_pressed("right"):
		start_turning(Direction.LEFT)
	if event.is_action_pressed("left"):
		start_turning(Direction.RIGHT)
	if event.is_action_pressed("up"):
		start_turning(Direction.UP)
	if event.is_action_pressed("down"):
		start_turning(Direction.DOWN)

func start_turning(direction):
	if respawning or won or lost or interpolation != 0 or not $GravityTimer.is_stopped():
		return
	is_turning = true
	print("turning " + str(direction))
	match direction:
		Direction.RIGHT:
			rotation_direction = Direction.RIGHT
			adjust_transform(right_shift)
		Direction.LEFT:
			rotation_direction = Direction.LEFT
			adjust_transform(Vector3(-1, 1, 0) * right_shift)
		Direction.UP:
			rotation_direction = Direction.UP
			adjust_transform(Vector3(0, 1, -1) * down_shift)
		Direction.DOWN:
			rotation_direction = Direction.DOWN
			adjust_transform(down_shift)
	#adjust_orientation()
			
func adjust_transform(shift):
	update_shifts()
	translation += Vector3(0, 5, 0) + shift
	print(translation)
	$RigidBody.translation = -shift
	var angle = (PI / 2.0)
	if true:
		match rotation_direction:
			Direction.RIGHT:
				$RigidBody.transform = $RigidBody.transform.rotated(Vector3(0, 0, -1), angle)
			Direction.LEFT:
				$RigidBody.transform = $RigidBody.transform.rotated(Vector3(0, 0, 1), angle)
			Direction.UP:
				$RigidBody.transform = $RigidBody.transform.rotated(Vector3(1, 0, 0), angle)
			Direction.DOWN:
				$RigidBody.transform = $RigidBody.transform.rotated(Vector3(-1, 0, 0), angle)
	adjust_orientation()
	

func adjust_orientation():
	if rest_position == RestPosition.LYING:
		match rotation_direction:
			Direction.RIGHT, Direction.LEFT:
				if orientation == Orientation.PARRALEL:
					rest_position = RestPosition.STANDING
			Direction.UP, Direction.DOWN:
				if orientation == Orientation.ORTHOGONAL:
					rest_position = RestPosition.STANDING
	elif rest_position == RestPosition.STANDING:
		rest_position = RestPosition.LYING
		match rotation_direction:
			Direction.RIGHT, Direction.LEFT:
				orientation = Orientation.PARRALEL
			Direction.UP, Direction.DOWN:
				orientation = Orientation.ORTHOGONAL
				
func update_shifts():
	if rest_position == RestPosition.STANDING:
		print("Standing")
		right_shift = Vector3(-1, 0.5, 0)
		down_shift = Vector3(0, 2.5, 1)
	else: match orientation:
		Orientation.PARRALEL:
			right_shift = Vector3(1, 1, 0)
			down_shift = Vector3(0, -0.5, -1)
			print("par")
		Orientation.ORTHOGONAL:
			right_shift = Vector3(1.5, -0.5, 0)
			down_shift = Vector3(0, -1.5, 1.5)
			print("ort")
	print(down_shift)
		
	
const movement_duration = 0.2

func _physics_process(delta):
	update_labels()	
	return;
	if is_turning:
		var step = (delta / movement_duration)
		var angle = (PI / 2.0) * step
		var body = $RigidBody
		#match rotation_direction:
		#	Direction.RIGHT:
		#		body.transform = body.transform.rotated(Vector3(0, 0, -1), angle)
		#	Direction.LEFT:
		#		body.transform = body.transform.rotated(Vector3(1, 0, 0), angle)
		#	Direction.UP:
		#		body.transform = body.transform.rotated(Vector3(0, 0, 1), angle)
		#	Direction.DOWN:
		#		body.transform = body.transform.rotated(Vector3(-1, 0, 0), angle)
		
		interpolation += step
		if interpolation > 1:
			is_turning = false
			interpolation = 0
			update_shifts()

func update_labels():
	pass

func win():
	print("WIN !!")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
