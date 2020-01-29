extends "res://Scripts/AbstractWorld.gd"
var stepBus
func _ready():
	world = 1
	level = 2
	

func _startLevel():
	._startLevel()
	
# warning-ignore:return_value_discarded
	connect("pet_activated",self,"pet_obtained")
#	Audio settings
	music.stream = load("res://ressources/music/cave-lvl1-theme.ogg")
	Player._setStepType(Player.GROUND_TYPE.STONE)
	stepBus = AudioServer.get_bus_index("steps")
	AudioServer.add_bus_effect(stepBus, AudioEffectReverb.new())
	$Loop.play()
	$Drips.play()
	
	Player.playerControlled = false
	Pet.get_node("StaticHover").play()
	Pet.position = $StartPet.position
	
func _endLevel():
	._endLevel()
	AudioServer.remove_bus_effect(stepBus,0)
	$Loop.stop()
	$Drips.stop()

# warning-ignore:unused_argument
func _process(delta):
	if levelStarted:
#		Player.stop_1_2 = get_node("End_slide").position.x
		if Player.position.x > get_node("End_slide").position.x + 10 && Player.is_on_floor():
			Player.get_node("PlayerSprite").animation = "static"
			Player.get_node("PlayerSprite").flip_h = true
			Player.look_right = false
			Player.playerControlled= false
			Player.move_and_slide(Vector2(-10,10),Vector2(-1,-1))
			
		else :
			Player.playerControlled= true
			
		_setVisibility()
	
	
func _setVisibility():
	if Pet.activated:
		visibility.set_color(Color(0.2, 0.2, 0.2))
	else:
		visibility.set_color(Color(0.0, 0.0, 0.0))
		
func pet_obtained():
	music.play()