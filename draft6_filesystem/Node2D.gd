extends Node2D

func _ready():
	#save_config()
	print(load_config())
		
func save_config():
	var path = "user://config.ini"
	var config = ConfigFile.new()
	config.set_value("options", "difficulty", "hard")
	config.set_value("audio", "music_volume", 42)
	
	var err = config.save(path)
	if err != OK:
		print("Some error occured")
		
func load_config():
	var path = "user://config.ini"
	var config = ConfigFile.new()
	
	var default_options = {
		"difficulty": "easy",
		"music_volume": 80
	}
	
	var err = config.load(path)
	if err != OK:
		return default_options
	var options = {}
	options.difficultiy = config.get_value("options", "difficulty")
	options.music_volume = config.get_value("audio", "music_volume")
	
	return options
