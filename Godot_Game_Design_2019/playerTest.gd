extends KinematicBody2D

# This demo shows how to build a kinematic controller.

# Member variables
var GRAVITY = 1200.0 # pixels/second/second

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 300
const MAX_WALK = 300
const STOP_FORCE = 1500
const JUMP_SPEED = 500
const JUMP_MAX_AIRBORNE_TIME = 0.5

const SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

var velocity = Vector2()
var on_air_time = 100
var jumping = false
var on_ladder = false

var screen_size

var prev_jump_pressed = false

func _ready():
    screen_size = get_viewport_rect().size
	
func _process(delta):
	# Create forces
	var motion = Vector2(0, GRAVITY)
	
	var walk_left = Input.is_action_pressed("ui_left")
	var walk_right = Input.is_action_pressed("ui_right")
	var jump = Input.is_action_pressed("ui_up")
	var stop = true
	
	if walk_left:
		motion.x = -WALK_FORCE
		$AnimatedSprite.animation = "walk"
		stop = false
	elif walk_right:
		motion.x = WALK_FORCE
		$AnimatedSprite.animation = "walk"
		stop = false
	else:
		$AnimatedSprite.animation = "static"
		
	if on_ladder == true:
		GRAVITY = 0
		if Input.is_action_just_pressed("ui_up"):
			jump = false
			motion.y = -WALK_FORCE
		elif Input.is_action_just_pressed("ui_down"):
			motion.y = WALK_FORCE
		else:
			motion.y = 0
	else:
		GRAVITY = 1200.0
	
	if stop:
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		
		vlen -= STOP_FORCE * delta
		if vlen < 0:
			vlen = 0
		
		velocity.x = (vlen * vsign) * 0.996
	
	# Integrate forces to velocity
	if(abs(velocity.x) < MAX_WALK):
		velocity.x += motion.x * delta
	
	velocity.y += motion.y * delta
	
		# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if is_on_floor():
		on_air_time = 0
		
	if jumping and velocity.y > 0:
		# If falling, no longer jumping
		jumping = false
	
	if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping:
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		velocity.y = -JUMP_SPEED
		jumping = true
	
	on_air_time += delta
	prev_jump_pressed = jump
