extends Area2D

var is_passed = false

func _on_Pet_activate_body_entered(body):
	if body.name == "Player" && !is_passed:
		print("eerer")
		Player.page = 2
		Player.launch_dialog = true
		Pet._activate()

func _on_Pet_activate_body_exited(body):
	if body.name == "Player" && !is_passed:
		Player.page = 3
		Player.launch_tuto = true
		is_passed = true
