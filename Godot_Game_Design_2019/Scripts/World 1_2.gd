extends "res://Scripts/AbstractWorld.gd"
var stepBus
func _ready():
	world = 1
	level = 2
	

func _startLevel():
	._startLevel()
	
	connect("pet_activated",self,"pet_obtained")
#	Audio settings
	music.stream = load("res://ressources/music/cave-lvl1-theme.ogg")
	player._setStepType(player.GROUND_TYPE.STONE)
	stepBus = AudioServer.get_bus_index("steps")
	AudioServer.add_bus_effect(stepBus, AudioEffectReverb.new())
	$Loop.play()
	$Drips.play()
	pet.get_node("StaticHover").play()
	
	
func _endLevel():
	._endLevel()
	AudioServer.remove_bus_effect(stepBus,0)
	$Loop.stop()
	$Drips.stop()

func _process(delta):
	if levelStarted:
		player.stop_1_2 = get_node("End_slide").position.x
		if player.position.x > get_node("End_slide").position.x + 10 && player.is_on_floor():
				player.get_node("PlayerSprite").animation = "static"
				player.get_node("PlayerSprite").flip_h = true
				player.look_right = false
				player.walk_1_2 = true
		_setVisibility()
	
	
func _setVisibility():
	if pet.activated:
		visibility.set_color(Color(0.2, 0.2, 0.2))
	else:
		visibility.set_color(Color(0, 0, 0))
		
func pet_obtained():
	music.play()