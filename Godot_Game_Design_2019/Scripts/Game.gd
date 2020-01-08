extends Node2D

var level
var cur_level = 0
var cur_world = 0
var world_list = []

func _ready():
#	intialize worlds and level list
	var i = 0
	for world in get_child(find_node("Worlds").get_index()).get_children():
		if world.name != "AbstractWorld": #AbstractWorld is an abstract node and serve as a parent class
			var level_list = []
			for level in world.get_children():
				level_list.append(level)
			world_list.append(level_list)
		else:
			print("ignoring abstract world")
	
	

func _process(delta):
#	TODO move to level 1 2
	$"Player".stop_1_2 = getlevel(1,2).get_node("End_slide").position.x
	level = $"Player".level
	
	if level != 0:
		cur_level = level
		$Player.cur_level = level
	
	setLevel(1,2,getlevel(1,1))
	setVisibility($"Visibility")
	
func setVisibility(canvas):
	if cur_level == 1.1:
		var color
		var start_fall = getlevel(1,1).get_node("Position2D").position.y
		
		if $Player.position.y < start_fall:
			color = 1
		else :
			var end_fall = getlevel(1,1).get_node("Exit").position.y
			var dist_player_fall = end_fall - $Player.position.y
			color = dist_player_fall / end_fall
			if color < 0:
				color = 0
		
		
		canvas.set_color(Color(color, color, color))
	
	if cur_level == 1.2:
		if $Player.position.x > getlevel(1,2).get_node("End_slide").position.x + 10 && $Player.is_on_floor():
			$Player.walk_1_2 = true
			$Player/PlayerSprite.animation = "static"
			$Player/PlayerSprite.flip_h = true
			$Player.look_right = false
		
		var pet = $Pet
		if pet.activated:
			canvas.set_color(Color(0.2, 0.2, 0.2))
		else:
			canvas.set_color(Color(0, 0, 0))
			
func setLevel(world,level,oldlevel):
	var player = $Player
	getlevel(world,level).show()
	oldlevel.hide()
	
	var start = getlevel(world,level).get_node("Start").position
	var x = start.x
	var y = start.y
	player.position.x = x
	player.position.y = y

#		TODO move to level 1_2
	$Player/PlayerSprite.animation = "static"
	$Player/PlayerSprite.flip_h = true
	player.look_right = false
	player.level = 0;
func getlevel(world,level):
	return world_list[world-1][level-1]