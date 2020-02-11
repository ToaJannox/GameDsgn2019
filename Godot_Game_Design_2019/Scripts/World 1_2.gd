extends "res://Scripts/AbstractWorld.gd"
var stepBus
var dinette_is_passed = false
var wait_push_button = false

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
	if wait_push_button:
		check_end_1_1()

var pressed_e = false
var done = false
			
func check_end_1_1():
	if Input.is_action_just_pressed("ui_accept"):
		pressed_e = true
	if pressed_e && !done:
		Player.get_node("Camera2D_Player").clear_current()
		$Camera_door.make_current()
		$Camera_door/Timer.start()

func _on_Timer_timeout():
	self.remove_child(get_node("Decor_environment_lights/Door_end"))
	Player.get_node("Camera2D_Player").make_current()
	$Camera_door.clear_current()
	$Camera_door/Timer.stop()
	done = true

func _setVisibility():
	if Pet.activated:
		visibility.set_color(Color(0.5, 0.5, 0.5))
	else:
		visibility.set_color(Color(0.3, 0.3, 0.3))
		
func pet_obtained():
	music.play()

func _on_Exit_1_2_body_entered(body):
	if body.name == "Player":
		Player.position = $"Start_save".position

func _on_Dinette_body_entered(body):
	if body.name == "Player" && !dinette_is_passed:
		visibility.set_color(Color(0.8, 0.8, 0.8))
		Player.page = 2
		Player.launch_tuto = true
		dinette_is_passed = true

var light_end_on = false
func _on_Light_end_on_body_entered(body):
	if body.name == "Player" && !light_end_on:
		$Button_end/Light2D.show()
		
func _on_Button_end_body_entered(body):
	if body.name == "Pet":
		wait_push_button = true
		$Button_end/Polygon2D.show()

func _on_Button_end_body_exited(body):
	if body.name == "Pet":
		wait_push_button = false
		$Button_end/Polygon2D.hide()
