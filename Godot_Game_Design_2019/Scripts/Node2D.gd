extends Node2D

var level
var cur_level

func _process(delta):
	$"Player".stop_1_2 = $"World 1_2"/"End_slide_1_2".position.x
	
	level = $"Player".level
	
	if level != 0:
		cur_level = level
		$Player.cur_level = level
	
	setLevel()
	setVisibilite($"Visibilité")
	
func setVisibilite(canvas):
	if cur_level == 1.1:
		canvas.set_color(Color(1, 1, 1))
	
	if cur_level == 1.2:
		if $Player.position.x > $"World 1_2"/"End_slide_1_2".position.x + 10 && $Player.is_on_floor():
			$Player.walk_1_2 = true
			$Player/PlayerSprite.animation = "static"
			$Player/PlayerSprite.flip_h = true
			$Player.look_right = false
			
		var pet = $Pet
		if pet.activated:
			canvas.set_color(Color(0.3, 0.3, 0.3))
		else:
			canvas.set_color(Color(0, 0, 0))
		
func setLevel():
	var player = $Player
	
	if level == 1.1:
		var x = $"World 1_1"/"Start 1_1".position.x
		var y = $"World 1_1"/"Start 1_1".position.y
		player.position.x = x
		player.position.y = y
		player.level = 0;
		
	if level == 1.2:
		$Player/PlayerSprite.animation = "static"
		$Player/PlayerSprite.flip_h = true
		player.look_right = false
		var x = $"World 1_2"/"Start 1_2".position.x
		var y = $"World 1_2"/"Start 1_2".position.y
		player.position.x = x
		player.position.y = y
		player.level = 0;
