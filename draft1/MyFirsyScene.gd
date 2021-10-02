extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().change_scene("res://second_scene.tscn")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func myFunc():
	var trans = Transform2D()
	trans.x = Vector2(1, 0)
	trans.y = Vector2(1, 0)
	
	var vec = Vector2(1, 0)
	var unit = vec.normalized()
	
	
	var rotateMatrix = Transform2D().rotated(deg2rad(90))
	var scaleMAtrix = Transform2D().scaled(Vector2(1, 2))
	var translateMatrix = Transform2D().translated(Vector2(1, 1))
	var combinedMatrix = translateMatrix * scaleMAtrix * rotateMatrix
	
	$Sprite3.transform *= combinedMatrix


func _on_Button_pressed():
	$Sprite.visible = not $Sprite.visible
	

