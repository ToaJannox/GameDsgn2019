extends KinematicBody2D

# Declare member variables here.
var GRAVITY = 1500.0

const FALL_SPEED = 1500

const WALK_SPEED = 300

var velocity = Vector2()
var motion

var on_air_time = 0

func _process(delta):
	motion = Vector2(0, GRAVITY)