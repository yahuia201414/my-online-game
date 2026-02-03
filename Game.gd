extends Node2D

# المشهد الجاهز للاعب
var player_scene = preload("res://Scenes/player.tscn")
@onready var spawner = $PlayerSpawner

# لاعب محلي و dictionary لكل اللاعبين
var local_player: Node = null
var spawned_players = {} # player_id -> player node

func _ready():
	multiplayer.peer_connected.connect(_on_peer_connected)

	# سباون اللاعب المحلي مرة واحدة فقط
	if multiplayer.is_server() or multiplayer.is_client():
		spawn_local_player()

func _on_peer_connected(id):
	# سباون اللاعبين الآخرين عند الاتصال
	if id != multiplayer.get_unique_id():
		spawn_remote_player(id)

func spawn_local_player():
	var id = multiplayer.get_unique_id()
	if spawned_players.has(id):
		return # منع سباون مرتين
	var player = player_scene.instantiate()
	player.player_id = id
	add_child(player)
	player.global_position = spawner.global_position
	spawned_players[id] = player
	local_player = player

func spawn_remote_player(id):
	if spawned_players.has(id):
		return
	var player = player_scene.instantiate()
	player.player_id = id
	add_child(player)
	player.global_position = spawner.global_position
	spawned_players[id] = player
