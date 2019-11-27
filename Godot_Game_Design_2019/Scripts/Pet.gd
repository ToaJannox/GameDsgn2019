extends KinematicBody2D

const MAX_TIME_MOVE = 0.7
const SPEED_MOVE = 15

var velocity = Vector2()

var time_move = 0
var up = false

func _process(delta):
	velocity.y = up_down(delta)
	
	var Player = get_node("../Player")
		
	velocity = move_and_slide(velocity, Vector2(0, -1))


# Make the up/down constant movement
func up_down(delta):
	time_move += delta
	
	if up:
		velocity.y = SPEED_MOVE
	else:
		velocity.y = -SPEED_MOVE
		
	if time_move >= MAX_TIME_MOVE:
		up = !up
		time_move = 0
	
	return velocity.y
