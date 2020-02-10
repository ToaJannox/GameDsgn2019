extends Area2D

var is_passed = false

func _on_Dinette_body_entered(body):
	if body.name == "Player" && !is_passed:
		Player.page = 2
		Player.launch_tuto = true
		is_passed = true
