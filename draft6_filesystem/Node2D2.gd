extends Node2D

var player_name = "LINK"
var player_score = 550

func _ready():
	# create_file()
	print(read_file())
	
func create_file():
	var path = "user://save.dat"
	# Create a new file project
	var file = File.new()
	
	# Open the file for writing
	var err = file.open(path, File.WRITE)
	
	# Simple error checking
	if err != OK:
		print("An error occured")
		return
		
	# Store the player data
	file.store_var(player_name)
	file.store_var(player_score)
	
	# Release the file handle
	file.close()
	
func read_file():
	var path = "user://save.dat"
	
	# Create a new File object
	var file = File.new()
	
	# Open the file for reading
	var err = file.open(path, File.READ)
	# SImple error checking
	if err != OK:
		print("An error occured")
		return
	var read = {}
	read.player_name = file.get_var()
	read.player_score = file.get_var()
	
	file.close()
	return read
	
