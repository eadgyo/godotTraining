extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var adder = Adder.new()
	
	var res = adder.add(20, 49)
	print(res)
	
	var res2 = adder.add(2, 23)
	print(res2)
	
	print(adder.get_call_count())
