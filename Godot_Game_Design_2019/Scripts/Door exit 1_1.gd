extends Area2D

func _on_Exit_1_1_body_entered(body):
	if body.name == "Player":
		get_node("../Player").level = 1.2;