extends Node2D


func _ready():
	var dir = Directory.new()
	
	var err = dir.open("res://")
	if err != OK:
		print("An error occured")
		return
		
	dir.list_dir_begin()
	var name = dir.get_next()
	while name != "":
		if dir.current_is_dir():
			print("dir : ", name)
		else:
			print("file : ", name)
		name = dir.get_next()
	dir.list_dir_end()
	
	print("file exists ", dir.file_exists("icon.png"))

