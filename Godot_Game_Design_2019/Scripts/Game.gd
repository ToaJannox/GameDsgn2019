extends Node2D

var world_list = []

func _ready():
#	intialize worlds and level list
	for world in get_child(find_node("Worlds").get_index()).get_children():	
		if world.name != "AbstractWorld":
			var level_list = []
			for level in world.get_children():
				level_list.append(level)
				level.hide()
			world_list.append(level_list)
	switchlevel(getlevel(1,1),null)

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
	
func _process(delta):
	var player = $Player
	if player.level == 1:
		if !(player.tuto_walk) && player.is_on_floor():
			launch_tuto(0) 
		
func getlevel(world,level):
	return world_list[world-1][level-1]

func switchlevel(newlevel,oldlevel):
	if oldlevel != null:
		oldlevel._endLevel()
		oldlevel.hide()
	setLevel(newlevel,oldlevel)
	newlevel._startLevel()

func launch_tuto(page):
	$Player.tuto_is_reading = true
	$Tutorial/RichTextLabel.page = page
	$Tutorial.position.x = $Player/Camera2D_Player.position.x
	$Tutorial.position.y = $Player/Camera2D_Player.position.y
	print($Tutorial.position.x)
	print($Tutorial.position.y)
	print($Player/Camera2D_Player.position.x)
	print($Player/Camera2D_Player.position.y)
	$Tutorial.show()
	$Tutorial/RichTextLabel.start = true
	if $Tutorial/RichTextLabel.finish :
		$Tutorial/Timer.stop()
		$Tutorial.hide()