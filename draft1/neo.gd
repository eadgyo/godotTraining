extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _on_button_pressed():
	print("Bonjour neo")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("pressed", self, "_on_button_pressed")
	Gamestate.test()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
