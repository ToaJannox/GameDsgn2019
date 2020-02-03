extends "res://Scripts/AbstractWorld.gd"
var stepBus
func _ready():
	world = 1
	level = 2
	

func _startLevel():
	._startLevel()
	
#	Audio settings
	music.stream = load("res://ressources/music/cave-lvl1-theme.ogg")
	Player._setStepType(Player.GROUND_TYPE.STONE)
	stepBus = AudioServer.get_bus_index("steps")
	AudioServer.add_bus_effect(stepBus, AudioEffectReverb.new())
	$Loop.play()
	$Drips.play()
	
	Fox.position = $Start_Fox.position
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
		Player.stop_1_2 = get_node("End_slide").position.x
		if Player.position.x > get_node("End_slide").position.x && Player.is_on_floor():
			player_slide(delta)
			
		_setVisibility()
	
func player_slide(delta):
	Player.get_node("PlayerSprite").animation = "static_without_pet"
	Player.get_node("PlayerSprite").flip_h = true
	Player.look_right = false
	Player.playerControlled = false
	
	Player.velocity.x = -(Player.WALK_SPEED)
	var vsign = sign(Player.velocity.x)
	var vlen = abs(Player.velocity.x)
	
	vlen -= Player.STOP_FORCE * delta
	if vlen < 0:
		vlen = 0
	
	Player.velocity.x = (vlen * vsign)
	Player.velocity = Player.move_and_slide(Player.velocity,Vector2(0,-1))
	
func _setVisibility():
	if Pet.activated:
		visibility.set_color(Color(0.2, 0.2, 0.2))
	else:
		visibility.set_color(Color(0.0, 0.0, 0.0))
		
func pet_obtained():
	music.play()