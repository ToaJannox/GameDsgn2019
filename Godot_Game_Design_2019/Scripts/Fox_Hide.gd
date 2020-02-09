extends Position2D

func _on_Fox_hide_body_entered(body):
	if body.name == "Player":
		Fox.activated = true
		$Fox_hide/Pet.hide()
