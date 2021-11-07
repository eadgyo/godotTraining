extends Spatial

func _ready():
	next_level()
	
func _on_block_won():
	$LevelLoad.start()

signal levels_ended()

const levels_path = "res://levels"
	
var level_list = []
var current_level
var current_level_id = 0

func _enter_tree():
	var dir = Directory.new()
	
	dir.open(levels_path)
	dir.list_dir_begin()
	var file = dir.get_next()
	while file != "":
		if file == "." or file == "..":
			file = dir.get_next()
			continue
		level_list.push_back(levels_path.plus_file(file))
		file = dir.get_next()
	level_list.sort()
	current_level_id = -1
	
func get_next_level():
	current_level_id += 1
	if current_level_id == level_list.size():
		emit_signal("levels_ended")
		return ""
	return level_list[current_level_id]
		
	
func next_level():
	var next_level = get_next_level()
	if next_level == "":
		return
	
	if current_level != null:
		current_level.queue_free()
	current_level = load(next_level).instance()
	add_child(current_level)
	$Block.start_point = str($Block.get_path_to(current_level)) + "/Start"
	$Block.respawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
