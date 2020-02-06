extends Area2D

func _on_Dinette_body_entered(body):
	if body.name == "Player":
		Player.page_tuto = 2
		Player.launch_tuto = true
