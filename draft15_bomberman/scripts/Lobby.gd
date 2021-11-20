extends Control


func _ready():
	Gamestate.connect("waiting_for_players", self, "")

func _process(delta):
	var players = Gamestate.get_players()
	var text = ""
	
	for p in players.values():
		text += p + "\n"
	$PanelWaitPlayers/LabelPlayerList.text = text
	$PanelWaitPlayers/LabelPlayerCount.text = str(len(players.values()))


func host_game(port):
	var host = NetworkedMultiplayerENet.new()
	host.create_server(int(port))
	get_tree().set_network_peer(host)
	Gamestate.player_nickname = "super_ronan"
	Gamestate.register_player_to_server(1, Gamestate.player_nickname)

func join_game(ip, port):
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, int(port))
	Gamestate.player_nickname = "ronan"
	get_tree().set_network_peer(host)

func on_waiting():
	$PanelTitleScene/LabelStatus.text = "Waiting"

func _on_ButtonJoin_pressed():
	join_game($PanelTitleScene/JoinAddress.text, $PanelTitleScene/Port.text)
	$PanelTitleScene/LabelStatus.text = "Joined"
	
func _on_ButtonHost_pressed():
	host_game($PanelTitleScene/Port.text)
	$PanelTitleScene/LabelStatus.text = "Server started"
	
func _on_ButtonStart_pressed():
	if Gamestate.game_ready():
		Gamestate.start_game()



func _on_PlayerName_text_changed(new_text):
	Gamestate.player_nickname = new_text


func _on_Button_pressed():
	pass
