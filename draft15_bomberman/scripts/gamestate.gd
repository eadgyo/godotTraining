extends Node
signal game_started
signal waiting_for_players

var players = {}
var player_nickname = "Dummy"
var game_started = false


var MAX_PLAYERS = 4
var player_scene = preload("res://sub/Player.tscn")

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connection_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	
func _player_disconnected(id):
	# Each peer get this notification when a peer disapears
	var player_node = get_node("/root/Arena/Players/%s" % id)
	if player_node:
		player_node.queue_free()
	players.erase(id)

func check_network_id(id):
	return id == get_tree().get_network_unique_id()
	

func _connected_ok():
	# This method is only called from the newly connected
	# client. Hence we register ourself to the server.
	var player_id = get_tree().get_network_unique_id()
	# Note given this call
	rpc("register_player_to_server", player_id, player_nickname)
	# Now just wait fo the server to start the game
	emit_signal("waiting_for_players")
	
	
func _connected_fail():
	_stop_game("Cannot connect to server")
	
func _server_disconnected():
	_stop_game("Server connection lost")
	
master func register_player_to_server(id, name):
	# As server, we notify here if the new client is allowed to join the game
	if game_started:
		rpc_id(id, "_kicked_by_server", "Game already started")
	elif len(players) == MAX_PLAYERS:
		rpc_id(id, "_kicked_by_server", "Server is full")
	# Send to the newcomer the already present players
	for p_id in players:
		rpc_id(id, "register_player", p_id, players[p_id])
	# Now register the newcomer everywhere, note the newcomer's peer will
	# also be called
	rpc("register_player", id, name)
	# register_player is slave, so rpc won't call it on our peer
	# of course we could have it sync to avoid this
	register_player(id, name)

func get_players():
	return players

slave func register_player(id, name):
	players[id] = name
	
sync func start_game():
	# Load the main game scene
	var arena = load("res://sub/areana1.tscn").instance()
	get_tree().get_root().add_child(arena)
	#get_tree().get_root().replace_by(arena)
	var spawn_positions = arena.get_node("SpawnPositions").get_children()
	# Populate each player
	var i = 0
	for p_id in players:
		var player_node = player_scene.instance()
		player_node.set_name(str(p_id)) # Useful to retrieve the player node with a node path
		player_node.id = p_id
		player_node.position = spawn_positions[i].position
		player_node.set_network_master(p_id)
		arena.get_node("Players").add_child(player_node)
		i += 1
	emit_signal("game_started")
	
func _stop_game(message):
	print(message)
	var lobby = load("res://sub/Lobby.tscn").instance()
	get_tree().set_network_peer(null)
	get_tree().get_root().replace_by(lobby)
	
	
	
func game_ready():
	return true
