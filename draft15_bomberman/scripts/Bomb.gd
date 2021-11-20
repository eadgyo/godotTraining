extends StaticBody2D

const EXPLOSION_RADIUS = 3

var owner_id = 0
onready var explosion_scene = preload("res://sub/Explosion.tscn")
onready var tilemap = get_node("/root/Arena/TileMap")
onready var tile_solid_id = tilemap.tile_set.find_tile_by_name("Brick")
onready var arena = get_node("/root/Arena")

func centered_to_map(position):
	var localPosition = tilemap.to_local(position)
	var mapPosition = tilemap.world_to_map(localPosition)
	var result = tilemap.map_to_world(mapPosition)
	result.x += tilemap.cell_size.x / 2
	result.y += tilemap.cell_size.y / 2
	return result


func _ready():
	$AnimationPlayer.play("Explosion")

func propagate_explosion(centerpos, propagation):
	if propagation.x == 0 and propagation.y == 0:
		var tilepos = centerpos
		if tilemap.get_cellv(tilepos) != tile_solid_id:
			# BOOM
			var explosion = explosion_scene.instance()
			explosion.position = centered_to_map(tilepos)
			explosion.direction = propagation
			arena.add_child(explosion)
	
	for i in range(1, EXPLOSION_RADIUS + 1):
		var tilepos = centerpos + propagation * i
		if tilemap.get_cellv(tilepos) != tile_solid_id:
			# BOOM
			var explosion = explosion_scene.instance()
			explosion.position = centered_to_map(tilepos)
			explosion.direction = propagation
			arena.add_child(explosion)
		else:
			break


func _on_AnimationPlayer_animation_finished(anim_name):
	propagate_explosion(position, Vector2())
	propagate_explosion(position, Vector2(0, 32))
	propagate_explosion(position + Vector2(0, -32), Vector2(0, -32))
	propagate_explosion(position, Vector2(32, 0))
	propagate_explosion(position + Vector2(-32, 0), Vector2(-32, 0))
	arena.remove_child(self)
	
