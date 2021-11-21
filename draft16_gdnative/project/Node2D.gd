extends Node2D

# load the SIMPLE library
#const ADDER = preload("res://gdnative/adder.gdns")
#onready var data = ADDER.new()

func _on_Button_pressed():
	var lib = GDNative.new()
	lib.library = load("res://gdnative/adder.gdnlib")
	
	lib.initialize()
	
	var array = lib.call_native("standard_varcall", "create_circle", [])
	var content = ""
	for row in array:
		var text = ""
		for ch in row:
			text += char(ch)
		content += text + "\n"
	print(content)
	lib.terminate()

