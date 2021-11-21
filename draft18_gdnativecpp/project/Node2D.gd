extends Node2D

func _on_Button_pressed():
	var libadder = load("res://Button.gdns")
	var adder = libadder.new()
	var a = 10
	var b = 15
	var c = adder.adder(a, b)
	print(c)
