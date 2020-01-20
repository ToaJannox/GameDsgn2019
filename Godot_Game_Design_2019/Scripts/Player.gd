extends KinematicBody2D

# Declare member variables here.
var GRAVITY = 1500.0

const FALL_SPEED = 1500

const WALK_SPEED = 150
const WALK_SPEED_MAX = 300

const LADDER_SPEED = 250

const STOP_FORCE = 4000

const JUMP_SPEED = 500
const MAX_JUMP_TIME = 0.3


const GROUND_TYPE = preload("res://Scripts/Ground_Type.gd").GROUND_TYPE
var velocity = Vector2()
var motion

var on_ladder = false
var look_right = true
var world = 0
var level = 0;
var hasPet = false
var walk_1_2 = true
var stop_1_2

var floor_y

var on_air_time = 0

# Called every frame, "delta" is the elapsed time since the previous frame.
func _process(delta):
		
	motion = Vector2(WALK_SPEED, GRAVITY)
	var pet_controlled = Input.is_key_pressed(KEY_F)
	
	if !pet_controlled:
		$Camera2D_Player.make_current()
		if world == 1 && level == 2:
			if !walk_1_2:
				controlled(delta)
			else:
				if position.x > stop_1_2:
					motion.x = -WALK_SPEED
				else:
					velocity = Vector2(0,0)
					motion = Vector2(0,0)
					$Polygon2D.show()
					$Polygon2D/RichTextLabel.start = true
					if $Polygon2D/RichTextLabel.finish :
						$Polygon2D/Timer.stop()
						$Polygon2D.hide()
						walk_1_2 = false
		else:
			controlled(delta)
	else:
		motion.x = 0
		velocity.x = 0
		$PlayerSprite.animation = "static"
		$Camera2D_Player.clear_current()
	
	if velocity.x < -WALK_SPEED_MAX:
		velocity.x = -WALK_SPEED_MAX
	elif velocity.x > WALK_SPEED_MAX:
		velocity.x = WALK_SPEED_MAX
		
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
		motion.x = -WALK_SPEED
		$PlayerSprite.animation = "walk"
		$PlayerSprite.flip_h = true
		stop = false
		look_right = false
		
	# walk right
	if walk_right && !walk_left:
		if !look_right:
			velocity.x = 0
		motion.x = WALK_SPEED
		$PlayerSprite.animation = "walk"
		$PlayerSprite.flip_h = false
		stop = false
		look_right = true
		
	# don't move x
	if (walk_right && walk_left) || (!walk_right && !walk_left):
		velocity.x = 0
		$PlayerSprite.animation = "static"
		
	# On ladder
	if on_ladder == true:
		if position.y < (floor_y - 10):
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
			$PlayerSprite.animation = "static"
	
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