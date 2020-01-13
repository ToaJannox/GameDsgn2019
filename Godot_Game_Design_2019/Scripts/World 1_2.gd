extends "res://Scripts/AbstractWorld.gd"
var stepBus
func _ready():
	world = 1
	level = 2
#	print(player.name)

func _startLevel():
	._startLevel()
	print("Level 2 started")
	player._setStepType(player.GROUND_TYPE.STONE)
	stepBus = AudioServer.get_bus_index("steps")
	AudioServer.add_bus_effect(stepBus, AudioEffectReverb.new())
	$Loop.play()
	$Drips.play()
	pet.get_node("StaticHover").play()
	
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