extends Node2D
var world = 0
var level = 0
var levelStarted = false
var player
var pet
var visibility

func _init():
	pass

func _ready():
	player = $"/root/Game/Player"
	pet = $"/root/Game/Pet"
	visibility = $"/root/Game/Visibility"
	
func _process(delta):
	pass
func _startLevel():
	levelStarted = true

func _endLevel():
	levelStarted = false

func _setVisibility():
	pass
