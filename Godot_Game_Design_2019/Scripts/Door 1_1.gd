extends Area2D

func _on_Door_exit_1_1_body_entered(body):
	if body.name == "Player":
		get_node("../Player").on_ladder = true;