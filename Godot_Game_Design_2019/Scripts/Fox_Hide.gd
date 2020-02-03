extends Area2D

func _on_Fox_Hide_body_entered(body):
	if body.name == "Player":
		Fox.activated = true
