extends Area2D

var is_passed = false

func _on_Dinette_body_entered(body):
	if body.name == "Player" && !is_passed:
		visibility.set_color(Color(0.2, 0.2, 0.2))
		Player.page = 2
		Player.launch_tuto = true
		is_passed = true
