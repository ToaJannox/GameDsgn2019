extends "res://Scripts/AbstractWorld.gd"

func _ready():
	world = 1
	level = 1
	
	
func _startLevel():
	._startLevel()
	music.stream = load("res://ressources/music/desert-theme.ogg");
	Player._setStepType(Player.GROUND_TYPE.SAND)
	Player.launch_tuto = true
	Player.page_tuto = 0
	$Loop.play()
	music.play()
	Fox.position = $Fox_Hide/Start_Fox.position
	
func _endLevel():
	._endLevel()
	$Loop.stop()
	
func _process(delta):
	if Player.position.x > $Pos_Disable_NoCollFront.position.x && Player.position.y > $Pos_Disable_NoCollFront.position.y:
		$Tilemaps/No_Collsisions/NoCollisionMap_front.set_z_index(-4)
	print(Fox.position)
	_setVisibility()
	
func _setVisibility():
	var color
	var start_fall = get_node("PitStart").position.y
		
	if Player.position.y < start_fall:
		color = 1
	else :
		var end_fall = get_node("Exit").position.y
		var dist_player_fall = end_fall - Player.position.y
		color = dist_player_fall / end_fall
		if color < 0:
			color = 0
	visibility.set_color(Color(color, color, color))
	
func _on_Exit_body_entered(body):
	if body.name == "Player":
		game.call_deferred("switchlevel",game.getlevel(1,2),self)
