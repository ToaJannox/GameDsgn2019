extends KinematicBody2D

# Declare member variables here.
var GRAVITY = 1500.0

const FALL_SPEED = 1500

const WALK_SPEED = 350

const LADDER_SPEED = 250

const STOP_FORCE = 4000

const JUMP_SPEED = 500
const MAX_JUMP_TIME = 0.1


const GROUND_TYPE = preload("res://Scripts/Ground_Type.gd").GROUND_TYPE
var velocity = Vector2()
var motion

var on_ladder = false
var look_right = true
var world = 0
var level = 0;
var playerControlled = false
var petControlled = false
var hasPet = false
var stop_1_2

var launch_tuto = false
var launch_dialog = false
var page_tuto = 0

var floor_y

var on_air_time = 0

func _process(delta):
	motion = Vector2(0, GRAVITY)

	if launch_tuto || launch_dialog:
		$Camera2D_Player.make_current()
		playerControlled = false
		if is_on_floor() && launch_tuto:
			$Tutorial.launch_tuto(page_tuto)
		if is_on_floor() && launch_dialog:
			$Girl_speak.launch_girl_speak(0)

	if petControlled: 
		$Camera2D_Player.clear_current()
		playerControlled = false
	
	if !playerControlled:
		if hasPet:
			$PlayerSprite.animation = "static_with_pet"
		else:
			$PlayerSprite.animation = "static_without_pet"
		motion.x = 0
		velocity.x = 0
	else:
		$Camera2D_Player.make_current()
		controlled(delta)	
		velocity.x += motion.x * delta
	
	velocity.y += motion.y * delta
	# Move Player
	velocity = move_and_slide(velocity, Vector2(0, -1))

func controlled(delta):
	var stop = true
	
	var walk_left = Input.is_action_pressed("ui_left")
	var walk_right = Input.is_action_pressed("ui_right")
	var walk_up = Input.is_action_pressed("ui_up")
	var walk_down = Input.is_action_pressed("ui_down")
	
	# walk left
	if walk_left && !walk_right:
		if look_right:
			velocity.x = 0
		velocity.x = -WALK_SPEED
		if hasPet:
			$PlayerSprite.animation = "walk_with_pet"
		else:
			$PlayerSprite.animation = "walk_without_pet"
		$PlayerSprite.flip_h = true
		stop = false
		look_right = false
		
	# walk right
	if walk_right && !walk_left:
		if !look_right:
			velocity.x = 0
		velocity.x = WALK_SPEED
		if hasPet:
			$PlayerSprite.animation = "walk_with_pet"
		else:
			$PlayerSprite.animation = "walk_without_pet"
		$PlayerSprite.flip_h = false
		stop = false
		look_right = true
		
	# don't move x
	if (walk_right && walk_left) || (!walk_right && !walk_left):
		velocity.x = 0
		if hasPet:
			$PlayerSprite.animation = "static_with_pet"
		else:
			$PlayerSprite.animation = "static_without_pet"
		
	# On ladder
	if on_ladder == true:
		#if position.y < (floor_y - 10) || position.y < (floor_y + 10):
		#	$PlayerSprite.animation= "climbing"
		$PlayerSprite.animation= "climbing"
		# Climb
		if walk_up && !walk_down:
			velocity.y = -LADDER_SPEED
		# Climb down
		elif walk_down && !walk_up:
			velocity.y = LADDER_SPEED
		else:
			velocity.y = 0
			motion.y = 0
	
	# Is it flying ?
	if is_on_floor():
		floor_y = position.y
		on_air_time = 0
	elif !on_ladder:	
		on_air_time += delta
		
	# Is jumping
	if walk_up && !on_ladder:
		if on_air_time < MAX_JUMP_TIME and walk_up:
			velocity.y = -JUMP_SPEED
	
	# Doesn't move
	if stop:
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		
		vlen -= STOP_FORCE * delta
		if vlen < 0:
			vlen = 0
		
		velocity.x = (vlen * vsign)

func _setStepType(type):
	$step.setStepType(type)
