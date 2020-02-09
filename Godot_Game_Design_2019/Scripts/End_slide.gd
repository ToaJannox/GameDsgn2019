extends Area2D

var is_passed = false

func _on_End_slide_body_entered(body):
	if body.name == "Player" && !is_passed:
		Player.page = 0
		Player.launch_dialog = true
		is_passed = true