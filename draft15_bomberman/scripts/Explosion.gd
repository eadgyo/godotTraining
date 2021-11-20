extends Sprite

var direction = Vector2()
onready var tilemap = get_node("/root/Arena/TileMap")
onready var animation = get_node("AnimationPlayer")
onready var players =  get_node("/root/Arena/Players")
onready var arena  = get_node("/root/Arena")

func _ready():
	if (direction.x != 0):
		self.rotate(PI/2)
	$Timer.start()

sync func set_tilemap(pos, id):
	tilemap.set_cellv(pos, id)

func _process(delta):
	if not is_network_master():
		return
	# Retrieve the title hit by the explosion and flatten it to the ground
	var tile_pos = tilemap.world_to_map(position)
	var tile_background_id = tilemap.tile_set.find_tile_by_name("Background")
	rpc("set_tilemap", tile_pos, tile_background_id)
	# Now that we know which title is blowing up retrieve the players and destroy them if they are on it
	for player in players.get_children():
		var playerpos = tilemap.world_to_map(player.position)
		if playerpos == tile_pos:
			var id = player.id
			player.rpc("damage", id)

func _on_Timer_timeout():
	arena.remove_child(self)
