extends Node2D
var world = 0
var level = 0
var player
var pet

func _ready():
	player = get_node("../Player")
	pet = get_node("../Pet")

func startLevel():
	pass

func endLevel():
	pass
	