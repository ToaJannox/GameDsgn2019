extends Position2D

var is_passed = false

func _on_Fox_hide_body_entered(body):
	if body.name == "Player" && !is_passed:
		Fox.activated = true
		Player.playerControlled = false
		Player.get_node("PlayerSprite").flip_h = false
		Player.get_node("Camera2D_Player").clear_current()
		Fox.get_node("Camera2D").make_current()
		$Fox_hide/Pet.hide()
		is_passed = true
