extends "res://Scripts/AbstractWorld.gd"

func _ready():
	._ready() # akin to java super._ready()
	world = 1
	level = 1

func _on_Exit_body_entered(body):
	if body.name == "Player":
		pass
