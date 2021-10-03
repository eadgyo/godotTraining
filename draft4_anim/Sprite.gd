extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_UP && event.pressed == false:
			if $AnimationPlayer.is_playing():
				$AnimationPlayer.play()
			else:
				$AnimationPlayer.play("New Anim")
		if event.scancode == KEY_DOWN && event.pressed == false:
			$AnimationPlayer.stop(false)
			
		if event.scancode == KEY_LEFT && event.pressed == false:
			$AnimationPlayer.play("New Anim 2")
			
		
func wood_chop():
	print("Chop my whood")

func animation_changed(old_name, new_name):
	print("why are you chaning animation")

func animation_finished(anim_name):
	print("animation " + anim_name + " is finished! ")

func animation_started(anim_name):
	print("animation " + anim_name + " is started! ") 


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("animation_changed", $AnimationPlayer, "animation_changed")
	self.connect("animation_finished", $AnimationPlayer, "animation_finished")
	self.connect("animation_started", $AnimationPlayer, "animation_started")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
