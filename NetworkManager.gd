extends Node

const PORT := 9999
const MAX_PLAYERS := 2

var room_password := ""
var multiplayer_peer_started := false

func host_game(password: String) -> void:
	room_password = password
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_PLAYERS)
	multiplayer.multiplayer_peer = peer
	multiplayer_peer_started = true
	print("HOST STARTED")

func join_game(password: String, host_ip: String) -> void:
	if not multiplayer_peer_started:
		var peer = ENetMultiplayerPeer.new()
		var err = peer.create_client(host_ip, PORT)
		if err != OK:
			print("Error connecting: ", err)
			return

		multiplayer.multiplayer_peer = peer
		multiplayer_peer_started = true
		print("JOINED SERVER")

		# انتظر حتى الاتصال قبل تنفيذ RPC
		await get_tree().process_frame
		while peer.get_connection_status() != MultiplayerPeer.CONNECTION_CONNECTED:
			await get_tree().process_frame

		print("Connected, checking password...")
		check_password.rpc(password)

@rpc
func check_password(password_to_check: String) -> void:
	if password_to_check == room_password:
		load_game.rpc()
	else:
		kick_player.rpc_id(multiplayer.get_remote_sender_id())

@rpc
func load_game() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

@rpc
func kick_player() -> void:
	multiplayer.multiplayer_peer.disconnect_peer(
		multiplayer.get_remote_sender_id()
	)

