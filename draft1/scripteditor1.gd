tool
extends EditorScript

var texture = preload("res://icon.png")

var origin = Vector2(500, 200)
var radius = 200

var num_sprites = 20

func _run():
	for i in range(num_sprites):
		var node = Sprite.new()
		node.texture = texture
		node.set_name("sprite_" + str(i))
		
		get_scene().add_child(node)
		node.set_owner(get_scene())
		
		node.scale = Vector2(0.5, 0.5)
		node.position = origin + Vector2(radius, 0).rotated((2 * PI) / num_sprites * i)
		
