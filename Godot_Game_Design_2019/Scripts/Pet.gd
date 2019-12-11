extends KinematicBody2D

# Up/Down movement
const MAX_TIME_MOVE = 0.9
const SPEED_MOVE = 25

const FLY_SPEED = 600
var FLY_SPEED_MAX = 600

const DISTANCE_MIN_X = 140
const DISTANCE_MAX_X = 160
const DISTANCE_Y = 100

var velocity = Vector2()

var time_move = 0
var up = false
var check_y = true
var activated = false;

func _process(delta):
	
	var player = get_node("../Player")

	if !activated :
		$CollisionShape2D_Pet.disabled = true
		up_down(delta)
		waitGirl(player)
	else:
		var controlled = Input.is_key_pressed(KEY_F)
			
		if controlled:
			$CollisionShape2D_Pet.disabled = false
			$Camera2D_Pet.make_current()
			controlled(delta)
			check_y = true
		else:
			autonomous(player)	
			$Camera2D_Pet.clear_current()
			$CollisionShape2D_Pet.disabled = true
		
		if !check_y:	
			velocity.y = player.velocity.y
			
		velocity = move_and_slide(velocity, Vector2(0, -1))

func waitGirl(player):
	if player.position.x < position.x + 30:
		activated = true
	

func controlled(delta):
		
	var walk_left = Input.is_action_pressed("ui_left")
	var walk_right = Input.is_action_pressed("ui_right")
	var walk_up = Input.is_action_pressed("ui_up")
	var walk_down = Input.is_action_pressed("ui_down")
	
	# Left
	if walk_left && !walk_right:
		print("left")
		velocity.x -= FLY_SPEED
		
	# Right
	if walk_right && !walk_left:
		print("right")
		velocity.x += FLY_SPEED
		
	# Up
	if walk_up && ! walk_down:
		print("up")
		velocity.y -= FLY_SPEED
		
	# Down
	if walk_down && !walk_up:
		print("down")
		velocity.y += FLY_SPEED
		
	# Don't move X
	var dontMoveX = (walk_right && walk_left) || (!walk_right && !walk_left)
	if dontMoveX:
		velocity.x = 0
		
	# Don't move Y
	var dontMoveY = (walk_down && walk_up) || (!walk_down && !walk_up)
	if dontMoveY:
		velocity.y = 0
		
	if dontMoveY:
		velocity.y = up_down(delta)
		
	checkVelocityX()
	checkVelocityY()

# When the pet just protect the Player
func autonomous(var player):
	var playerPos = player.position
	var playerLookRight = player.look_right
	
	if check_y:
		if position.y < player.position.y - 5:
			velocity.y = FLY_SPEED
		if position.y > player.position.y + 5:
			velocity.y = -FLY_SPEED
		if (position.y < player.position.y + 5) && (position.y > player.position.y - 5):
			position.y = player.position.y
			check_y = false
	
	# Look right
	if playerLookRight :
		# Too far left
		if (position.x - playerPos.x) < DISTANCE_MIN_X:
			velocity.x = FLY_SPEED
		# Too far right
		elif (position.x - playerPos.x) > DISTANCE_MAX_X:
			velocity.x = -FLY_SPEED
		# Just good
		else :
			velocity.x = 0
			velocity.x = player.velocity.x
	# Look left
	if !playerLookRight:
		# Too far left
		if (playerPos.x - position.x) > DISTANCE_MAX_X:
			velocity.x = FLY_SPEED
		# Too far right
		elif (playerPos.x - position.x) < DISTANCE_MIN_X:
			velocity.x = -FLY_SPEED
		# Just good
		else :
			velocity.x = 0
			velocity.x = player.velocity.x
	
	velocity.y += player.velocity.y
	
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

func checkVelocityX():
	if velocity.x < -FLY_SPEED_MAX:
		velocity.x = -FLY_SPEED_MAX
	elif velocity.x > FLY_SPEED_MAX:
		velocity.x = FLY_SPEED_MAX
	
func checkVelocityY():
	if velocity.y < -FLY_SPEED_MAX:
		velocity.y = -FLY_SPEED_MAX
	elif velocity.y > FLY_SPEED_MAX:
		velocity.y = FLY_SPEED_MAX