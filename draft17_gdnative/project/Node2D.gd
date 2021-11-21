extends Node2D



func _on_Button_pressed():
	var lib = GDNative.new()
	lib.library = load("res://gdnative/simple.gdnlib")
	
	lib.initialize()
	
	var array = lib.call_native("standard_varcall", "create_circle", [])
	


func _on_Button2_pressed():
	var lib = GDNative.new()
	lib.library = load("res://gdnative/simple.gdnlib")
	
	lib.initialize()
	var result = lib.call_native("standard_varcall", "libcurl_version", [])
	$Label.text = result
	
	lib.terminate()


