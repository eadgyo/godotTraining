extends Sprite


onready var tilemap = get_node("/root/Area/TileMap")
onready var animation = get_node("AnimationPlayer")

func _ready():
	if not is_network_master():
		return
	
	# Retrieve the title hit by the explosion and flatten it to the ground
	var tile_pos = tilemap.world_to_map(position)
	var tile_background_id = tilemap.tile_set.find_title_by_name("Background")
	tilemap.set_cellv(tile_pos, tile_background_id)
	# Now that we know which title is blowing up retrieve the players and destroy them if they are on it
	for player in get_tree().get_nodes_in_group("players"):
		var playerpos = tilemap.wolrd_to_map(player.position)
		if playerpos == tile_pos:
			player.rpc("damage", owner.id)

