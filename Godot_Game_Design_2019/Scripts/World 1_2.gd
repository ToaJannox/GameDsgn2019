extends "res://Scripts/AbstractWorld.gd"
var stepBus
var dinette_is_passed = false

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
	if levelStarted && !dinette_is_passed:
		Player.stop_1_2 = get_node("End_slide").position.x
		Player.look_right = false
			
		_setVisibility()

func _setVisibility():
	if Pet.activated:
		visibility.set_color(Color(0.2, 0.2, 0.2))
	else:
		visibility.set_color(Color(0.0, 0.0, 0.0))
		
func pet_obtained():
	music.play()

func _on_Exit_1_2_body_entered(body):
	if body.name == "Player":
		Player.position = $"Start_save".position

func _on_Dinette_body_entered(body):
	if body.name == "Player" && !dinette_is_passed:
		Player.page = 2
		Player.launch_tuto = true
		dinette_is_passed = true

