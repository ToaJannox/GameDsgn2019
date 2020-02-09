extends KinematicBody2D

var GRAVITY = 1500.0

const FALL_SPEED = 1500
const WALK_SPEED = 1000

var velocity = Vector2()
var motion

var activated = false
var end = false
var position_end

func _ready():
	$AnimatedSprite.animation = "None"

func _process(delta):
	motion = Vector2(0, GRAVITY)
	
	if activated:
		if !end:
			$AnimatedSprite.animation = "run"
			velocity.x = WALK_SPEED
		else:
			velocity.x = 0
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.animation = "sit"
			Fox.position = position_end
	else:
		velocity.x = 0
		
	velocity.y += motion.y * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
