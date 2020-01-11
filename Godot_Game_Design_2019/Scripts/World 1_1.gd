extends "res://Scripts/AbstractWorld.gd"

func _init():
	print("World 1 1 init")
func _ready():
	print("World 1 1 ready")
	world = 1
	level = 1

func _on_Exit_body_entered(body):
	if body.name == "Player":
		game.switchlevel(game.getlevel(1,2),self)

func _startLevel():
	pass

func _process(delta):
	_setVisibility()
func _setVisibility():
	var color
	var start_fall = get_node("PitStart").position.y
		
	if player.position.y < start_fall:
		color = 1
	else :
		var end_fall = get_node("Exit").position.y
		var dist_player_fall = end_fall - player.position.y
		color = dist_player_fall / end_fall
		if color < 0:
			color = 0
	visibility.set_color(Color(color, color, color))