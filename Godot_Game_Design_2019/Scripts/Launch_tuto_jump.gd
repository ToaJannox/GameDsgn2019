extends Area2D

func _on_Launch_tuto_jump_body_entered(body):
	print("hjer")
	if body.name == "Player":
		Player.launch_tuto = true
		Player.page_tuto = 1