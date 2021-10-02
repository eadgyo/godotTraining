extends Sprite

export var speed = 2000
var fire_scene = preload("res://fire_scene.tscn")
onready var timer = get_node("../Timer")
var shot_instance = null
var isFiringReady = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func shotfucked():
	if shot_instance != null:
		#get_parent().remove_child(shot_instance)
		shot_instance.free()		
		shot_instance = null
		isFiringReady = true
	print("ending")


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", self, "shotfucked")

func _process(delta):
	var direction = Vector2()
	if Input.is_action_pressed("ui_left"):
		direction.x = -1.0
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1.0
	elif Input.is_action_pressed("ui_up"):
		direction.y = -1.0
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1.0
	elif Input.is_action_pressed("ui_accept") and isFiringReady:
		shot_instance = fire_scene.instance()
		shot_instance.position = self.position + Vector2(100, 0)
		get_parent().add_child(shot_instance)
		isFiringReady = false
		timer.start()
		
	var velocity = direction * speed * delta 
	

	#position += velocity
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
