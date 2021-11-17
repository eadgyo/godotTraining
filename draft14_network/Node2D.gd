extends Node2D

var speed = Vector2(0, -200)
sync var alive = true

remote func update_pos_for_remotes(new_pos):
	position = new_pos
	
func _process(delta):
	if is_network_master():
		position += speed * delta
		if position.y < 0:
			position.y = 0
			rset("alive", false)
		rpc_unreliable("update_pos_for_remotes", position)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func host_game(port):
	var host = NetworkedMultiplayerENet.new()
	host.create_server(port)
	get_tree().set_network_peer(host)
	
func join_game(ip, port):
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, port)
	get_tree().set_network(host)

func finish_game(port):
	get_tree().set_network_peer(null)
