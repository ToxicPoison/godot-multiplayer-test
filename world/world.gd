extends Node

@onready var main_menu = $CanvasLayer/MainMenu
@onready var address_entry = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer/AddressEntry

const PLAYER = preload("res://player/player.tscn")
const TERRAIN = preload("res://environment/terrain.tscn")
const PORT = 9998
var enet_peer = ENetMultiplayerPeer.new()

func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


func _on_host_button_pressed():
	main_menu.hide()
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	add_player(multiplayer.get_unique_id())
	make_terrain()

func _on_join_button_pressed():
	main_menu.hide()
	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer
	make_terrain()

func add_player(peer_id):
	var player = PLAYER.instantiate()
	player.name = str(peer_id)
	add_child(player)

func make_terrain():
	var terrain = TERRAIN.instantiate()
	add_child(terrain)
	terrain.seed = 5 # work on this...
	terrain.position = Vector2(-terrain.width/2.0, -terrain.height/2.0)
	terrain.generate_terrain()
	
	
