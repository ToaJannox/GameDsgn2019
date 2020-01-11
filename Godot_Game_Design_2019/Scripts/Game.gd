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
	switchlevel(getlevel(1,1),null)
	
	

func _process(delta):
	pass
	
func setVisibility(canvas):
	pass

			
func setLevel(newlevel,oldlevel):
	var player = $Player
	newlevel.show()
	if oldlevel != null:
		oldlevel.hide()	
	var start = newlevel.get_node("Start").position
	var x = start.x
	var y = start.y
	player.position.x = x
	player.position.y = y
	player.level = newlevel.level
	player.world = newlevel.world
	
func getlevel(world,level):
	return world_list[world-1][level-1]

func switchlevel(newlevel,oldlevel):
	if oldlevel != null:
		oldlevel._endLevel()
		oldlevel.hide()
	setLevel(newlevel,oldlevel)
	newlevel._startLevel()
	
	