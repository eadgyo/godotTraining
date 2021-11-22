extends Node2D

const adder = preload("res://gdnative/Adder.gdns")
onready var data = adder.new()

func _ready():
	pass
	#print(lib.get_call_count())
	
	
	


func _on_Button_pressed():
	var res = data.add(1, 2)
	print(str(res))
	
	var res2 = data.get_call_count()
	print(res2)
