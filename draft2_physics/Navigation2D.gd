extends Navigation2D  

var start_point = Vector2()
var end_point = Vector2()
var path = []

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			start_point = event.position
		elif event.button_index == BUTTON_RIGHT:
			end_point = event.position

func _process(delta):
	path = get_simple_path(start_point, end_point, false)
	update()
	
func _draw():
	for point in path:
		draw_circle(point, 10, Color(1,1,1))
	draw_polyline(path, Color(1,0,0), 3.0, true)


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
