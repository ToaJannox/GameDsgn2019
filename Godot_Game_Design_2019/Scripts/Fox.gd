extends KinematicBody2D

var GRAVITY = 1500.0

const FALL_SPEED = 1500
const WALK_SPEED = 300

var velocity = Vector2()
var motion

var activated = false

func _ready():
	$AnimatedSprite.animation = "static"

func _process(delta):
	motion = Vector2(0, 0)
	
	if activated:
		$AnimatedSprite.animation = "run"
		velocity.x = WALK_SPEED
	
	velocity.y += motion.y * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))
	