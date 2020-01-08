extends Node2D

var level
var cur_level
var world_list = []

func _ready():
#	intialize worlds and level list
	var i = 0
	for world in get_child(find_node("Worlds").get_index()).get_children():
		var level_list = []
		for level in world.get_children():
			level_list.append(level)
		world_list.append(level_list)
	
	print(getlevel(1,1).get_path())
	

func _process(delta):
	$"Player".stop_1_2 = $"Worlds/World1/World 1_2"/"End_slide_1_2".position.x
	
	level = $"Player".level
	
	if level != 0:
		cur_level = level
		$Player.cur_level = level
	
	setLevel()
	setVisibilite($"Visibilité")
	
func setVisibilite(canvas):
	if cur_level == 1.1:
		var color
		var start_fall = $"Worlds/World1/World 1_1/Position2D".position.y
		
		if $Player.position.y < start_fall:
			color = 1
		else :
			var end_fall = $"Worlds/World1/World 1_1/Exit 1_1".position.y
			var dist_player_fall = end_fall - $Player.position.y
			color = dist_player_fall / end_fall
			if color < 0:
				color = 0
			
		canvas.set_color(Color(color, color, color))
	
	if cur_level == 1.2:
		if $Player.position.x > $"Worlds/World1/World 1_2"/"End_slide_1_2".position.x + 10 && $Player.is_on_floor():
			$Player.walk_1_2 = true
			$Player/PlayerSprite.animation = "static"
			$Player/PlayerSprite.flip_h = true
			$Player.look_right = false
			
		var pet = $Pet
		if pet.activated:
			canvas.set_color(Color(0.2, 0.2, 0.2))
		else:
			canvas.set_color(Color(0, 0, 0))
			
func setLevel():
	var player = $Player
	
	if level == 1.1:
		$"Worlds/World1/World 1_1".show()
		$"Worlds/World1/World 1_2".hide()
		var x = $"Worlds/World1/World 1_1"/"Start 1_1".position.x
		var y = $"Worlds/World1/World 1_1"/"Start 1_1".position.y
		player.position.x = x
		player.position.y = y
		player.level = 0;
		
	if level == 1.2:
		$"Worlds/World1/World 1_1".hide()
		$"Worlds/World1/World 1_2".show()
		var x = $"Worlds/World1/World 1_2"/"Start 1_2".position.x
		var y = $"Worlds/World1/World 1_2"/"Start 1_2".position.y
		player.position.x = x
		player.position.y = y
		$Player/PlayerSprite.animation = "static"
		$Player/PlayerSprite.flip_h = true
		player.look_right = false
		player.level = 0;
func getlevel(world,level):
	return world_list[world-1][level-1]