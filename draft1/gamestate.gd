extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _on_Area_entered(area):
	print("bonjour area")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Starting gamestate") 


func _on_button_pressed():
	print("Bonjour neo")

func test():
	print("testing autoload")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
