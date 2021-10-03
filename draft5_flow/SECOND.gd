extends Node2D

var dialog = ConfirmationDialog.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	dialog.dialog_text = "Are you sure ?"
	dialog.get_ok().text = "Yes"
	dialog.get_cancel().text = "No"
	dialog.connect("confirmed", self, "end")
	add_child(dialog)
	get_tree().set_auto_accept_quit(false)
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		dialog.popup()
func end():
	get_tree().quit()
