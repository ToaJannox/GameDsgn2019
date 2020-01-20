extends Node2D
var game
var world = 0
var level = 0
var levelStarted = false
var player
var pet
var visibility
var music

func _ready():
	game = $"/root/Game"
	player = $"/root/Game/Player"
	pet = $"/root/Game/Pet"
	visibility = $"/root/Game/Visibility"
	music = $"/root/Game/Music"
	
func _process(delta):
	pass
func _startLevel():
	levelStarted = true

func _endLevel():
	levelStarted = false
	music.stop()

func _setVisibility():
	pass
