extends Node2D

var level
var cur_level

func _process(delta):
	get_node("Player").stop_1_2 = get_node("End_slide_1_2").position.x
	
	level = get_node("Player").level
	
	if level != 0:
		cur_level = level
		get_node("Player").cur_level = level
	
	setLevel()
	setVisibilite(get_node("Visibilité"))
	
func setVisibilite(canvas):
	if cur_level == 1.1:
		canvas.set_color(Color(1, 1, 1))
	
	if cur_level == 1.2:
		var pet = get_node("Pet")
		if pet.activated:
			canvas.set_color(Color(0.3, 0.3, 0.3))
		else:
			canvas.set_color(Color(0, 0, 0))
		
func setLevel():
	var player = $Player
	
	if level == 1.1:
		var x = $"Start 1_1".position.x
		var y = $"Start 1_1".position.y
		player.position.x = x
		player.position.y = y
		player.level = 0;
		
	if level == 1.2:
		$Player/PlayerSprite.animation = "static"
		$Player/PlayerSprite.flip_h = true
		player.look_right = false
		var x = $"Start 1_2".position.x
		var y = $"Start 1_2".position.y
		player.position.x = x
		player.position.y = y
		player.level = 0;
