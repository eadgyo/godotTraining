extends Node2D

var label = Label.new()
var counter = 0
var clock = 0
var loader
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(0)
	$PauseMenu.dialog_text = "Paused"
	$PauseMenu.connect("popup_hide", self, "unpause")
	$PauseMenu.popup_exclusive = true
	$PauseMenu.pause_mode = Node.PAUSE_MODE_PROCESS
	add_child(label)
	loader = ResourceLoader.load_interactive("res://SECOND.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	counter += delta
	label.text = "%.1f" % counter
	var err = loader.poll()
	#if err == ERR_FILE_EOF:
		#print(loader.get_resource())
	label.text = "%d / %d loaded (%.1f s)" % [loader.get_stage(), loader.get_stage_count(), clock]
		
func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			$PauseMenu.popup()
			get_tree().set_pause(true)
		if event.scancode == KEY_SPACE:
			get_tree().change_scene_to(loader.get_resource())
			
func unpause():
	get_tree().set_pause(false)
