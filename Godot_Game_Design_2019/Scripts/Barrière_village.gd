extends StaticBody2D

func _on_Barriere_Village_Area_Fox_body_entered(body):
	if body.name == "Fox":
		Player.playerControlled = false
		Player.get_node("Camera2D_Player").clear_current()
		self.remove_child(get_node("Collision_barriere"))
		Fox.get_node("Camera2D").make_current()


func _on_Barriere_Village_Area_Fox_body_exited(body):
	if body.name == "Fox":
		Player.playerControlled = true
		Player.get_node("Camera2D_Player").make_current()
		Fox.get_node("Camera2D").clear_current()


func _on_Barriere_Village_Area_Destroyed_body_entered(body):
	if body.name == "Fox":
		get_node("Sprite_barriere_village").animation = "Cassee"
