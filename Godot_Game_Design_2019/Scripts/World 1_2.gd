extends "res://Scripts/AbstractWorld.gd"

func _init():
	print("World 1 2 init")
func _ready():
	print("World 1  ready")
	world = 1
	level = 2
#	print(player.name)

func _process(delta):
	if not levelStarted:
		player.stop_1_2 = get_node("End_slide").position.x
		if player.position.x > get_node("End_slide").position.x + 10 && player.is_on_floor():
				$player/PlayerSprite.animation = "static"
				$player/PlayerSprite.flip_h = true
				$player.look_right = false
				$player.walk_1_2 = true
	
	
func _setVisibility():
	if pet.activated:
		visibility.set_color(Color(0.2, 0.2, 0.2))
	else:
		visibility.set_color(Color(0, 0, 0))