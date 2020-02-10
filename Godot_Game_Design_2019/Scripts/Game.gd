extends Node2D

var world_list = []

func _ready():
#	intialize worlds and level list
	var worldsPath = "res://scenes/worlds"

	var dir = Directory.new()
	dir.open(worldsPath)
	dir.list_dir_begin()
	_add_dir_contents(dir,world_list)
	self.call_deferred("switchlevel",getlevel(1,2),null)

func switchlevel(newlevel,oldlevel,keep = false):
	if oldlevel != null:
		oldlevel.hide()	
		if(!keep):
			oldlevel._endLevel()
			self.remove_child(oldlevel)
	self.add_child(newlevel)
	
	newlevel.show()	
	var start = newlevel.get_node("Start").position
	Player.position = start
	Player.level = newlevel.level
	Player.world = newlevel.world
	newlevel._startLevel()

func getlevel(world,level):
	return world_list[world-1][level-1].instance()
		
func _add_dir_contents(dir, list):
	var file_name = dir.get_next()
	while (file_name != ""):
		if not file_name.begins_with("."):
			var path = dir.get_current_dir() + "/" + file_name
			if dir.current_is_dir():
				var levels = [];
				var subDir = Directory.new()
				subDir.open(path)
				subDir.list_dir_begin(true, false)
				_add_dir_contents(subDir,levels)
				if(OS.get_name()=="Windows"):
					list.push_back(levels)
				else:
					list.push_front(levels)
			else:
				if(OS.get_name()=="Windows"):
					list.push_back(load(path))
				else:	
					list.push_front(load(path))
		file_name = dir.get_next()
	dir.list_dir_end()
