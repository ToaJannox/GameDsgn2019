extends Node2D

var level
var cur_level = 0
var cur_world = 0
var world_list = []



func _ready():
#	intialize worlds and level list
	var i = 0
	for world in get_child(find_node("Worlds").get_index()).get_children():	
		if world.name != "AbstractWorld":
			var level_list = []
			for level in world.get_children():
				level_list.append(level)
			world_list.append(level_list)
	getlevel(1,1)._startLevel()
	setLevel(1,1,null)
	

func _process(delta):
#	TODO move to level 1 2
	
	
	if level != 0:
		cur_level = level
		$Player.cur_level = level
	
	setVisibility($"Visibility")
	
func setVisibility(canvas):
	pass

			
func setLevel(world,level,oldlevel):
	var player = $Player
	getlevel(world,level).show()
	if oldlevel == null:
		oldlevel.hide()	
	var start = getlevel(world,level).get_node("Start").position
	var x = start.x
	var y = start.y
	player.position.x = x
	player.position.y = y
	player.level = 0
	
func getlevel(world,level):
	return world_list[world-1][level-1]