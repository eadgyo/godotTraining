extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/Button.connect("pressed", self, "button_pressed")
	$HBoxContainer/LineEdit.connect("text_entered", self, "show_dialog")

func show_dialog(name):
	if name == "": name = "anonymous"
	$AcceptDialog.dialog_text = "Your are %s." % name
	$AcceptDialog.popup()
	
func button_pressed():
	show_dialog($HBoxContainer/LineEdit.text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
