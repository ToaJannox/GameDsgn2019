extends StaticBody2D

func _on_Barriere_Village_Area_Fox_body_entered(body):
	if body.name == "Fox":
		self.remove_child(get_node("Collision_barriere"))

func _on_Barriere_Village_Area_Fox_body_exited(body):
	if body.name == "Fox":
		Player.playerControlled = true
		Player.get_node("Camera2D_Player").make_current()
		Fox.get_node("Camera2D").clear_current()
		Fox.end = true
		Player.page = 1
		Player.launch_dialog = true


func _on_Barriere_Village_Area_Destroyed_body_entered(body):
	if body.name == "Fox":
		get_node("Sprite_barriere_village").animation = "Cassee"
