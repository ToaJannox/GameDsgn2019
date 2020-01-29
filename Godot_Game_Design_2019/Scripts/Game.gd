extends Node2D

var world_list = []

func _ready():
#	intialize worlds and level list
	var worldsPath = "res://scenes/worlds"

	var dir = Directory.new()
	dir.open(worldsPath)
	dir.list_dir_begin()
	_add_dir_contents(dir,world_list)
	switchlevel(getlevel(1,2),null)


func switchlevel(newlevel,oldlevel,keep = false):
	if oldlevel != null:
		oldlevel.hide()	
		if(!keep):
			oldlevel._endLevel()
			self.remove_child(oldlevel)
	self.add_child(newlevel)
	newlevel.show()	
	var start = newlevel.get_node("Start").position #TODO fix level position switch
	Player.position= start
	Player.level = newlevel.level
	Player.world = newlevel.world
	newlevel._startLevel()

func getlevel(world,level):
	return world_list[world-1][level-1].instance()

func launch_tuto(page):
	Player.playerControlled = false
	$Tutorial/RichTextLabel.page = page
	$Tutorial.position.x = Player.get_node("Camera2D_Player").position.x
	$Tutorial.position.y = Player.get_node("Camera2D_Player").position.y
	
	$Tutorial.show()
	$Tutorial/RichTextLabel.start = true
	if $Tutorial/RichTextLabel.finish :
		$Tutorial/Timer.stop()
		$Tutorial.hide()
		
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
				list.push_front(levels)
			else:
				list.push_front(load(path))
		file_name = dir.get_next()
	dir.list_dir_end()