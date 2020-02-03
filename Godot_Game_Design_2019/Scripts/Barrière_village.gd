extends StaticBody2D

func _on_Barriere_Village_Area_body_entered(body):
	if body.name == "Fox":
		$"Sprite_barrière_village".animation = "Cassee"
		$CollisionShape2D.disable = true

func _on_Barriere_Village_Area_Fox_body_entered(body):
	if body.name == "Fox":
		Player.get_node("Camera2D_Player").clear_current()
		Fox.get_node("Camera2D_Player").make_current()


func _on_Barriere_Village_Area_Fox_body_exited(body):
	if body.name == "Fox":
		Player.get_node("Camera2D_Player").make_current()
		Fox.get_node("Camera2D_Player").clear_current()
