extends Node2D
var ip = "127.0.0.1"
var port = 5000

onready var label = get_node("Label")

func _update_text(txt):
	label.text = label.text + "\n" + txt
	
sync func _sync_update_text(txt):
	_update_text("sync " + txt)

master func _master_update_text(txt):
	_update_text("master " + txt)
	
puppet func _slave_update_text(txt):
	_update_text("slave " + txt)
	
remote func _remove_update_text(txt):
	_update_text("remove " + txt)


func host_client(ip, port):
	_update_text("client")
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, port)
	get_tree().set_network_peer(host)

func host_server(port):
	_update_text("server")
	var host = NetworkedMultiplayerENet.new()
	set_network_master(1)
	host.create_server(port)
	get_tree().set_network_peer(host)


func _on_client_pressed():
	host_client(ip, port)

func _on_server_pressed():
	host_server(port)
	
func _on_ping_pressed():
	rpc('_sync_update_text', 'ping !')
	rpc('_master_update_text', 'ping !')
	rpc('_slave_update_text', 'ping !')
	rpc('_remove_update_text', 'ping !')
