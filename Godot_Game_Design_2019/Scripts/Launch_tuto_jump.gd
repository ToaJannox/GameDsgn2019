extends Area2D

var is_passed = false

func _on_Launch_tuto_jump_body_entered(body):
	if body.name == "Player":
		if !is_passed:
			Player.launch_tuto = true
			Player.page_tuto = 1
			is_passed = true