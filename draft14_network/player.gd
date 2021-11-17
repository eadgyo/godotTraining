extends Node

var player_scene = preload("res://playser_scene.tscn")
var score = 0

func peer_joined(peer_id):
	var player = player_scene.instance()
	get_tree().get_root().add_child(player)
	player.set_network_master(peer_id)


func _update(delta):
	if is_network_master():
		if Input.is_action_just_pressed("ui_up"):
			pass
	
slave func update_score(new_score):
	score = new_score
	
func on_player_killed():
	if is_network_master(): # Score should only be handled by master
		rpc("udpate_score", score + 100)
		update_score(score + 100)
		
