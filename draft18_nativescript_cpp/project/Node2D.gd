extends Node2D

func _ready():
	$Player.connect("test", self, "test_result")
	
func test_result():
	$Label.text = "Timer end"
	
func _on_Button_pressed():
	var libadder = load("res://Button.gdns")
	var adder = libadder.new()
	var a = 10
	var b = 15
	var c = adder.adder(a, b)
	print(c)


func _on_Button2_pressed():
	$Label.text = "reset"
	$Player.start(Vector2(50, 200))
	$Player.speed = 100.0
	$Player/Timer.start()
