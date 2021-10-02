extends Sprite

signal test(object)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var node = null

func testMyTheory(object):
	node.visible = false
	print("test thoery activated")
	if node.is_in_group("testGroup"):
		print("fuck")
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		print("hello back neo")

# Called when the node enters the scene tree for the first time.
func _ready():
	node = get_node("../Button2")
	self.connect("test", self, "testMyTheory")
	
func destructor():
	print("you were my only hope")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if event.is_action_pressed("ui_right"):
		emit_signal("test", self) 
