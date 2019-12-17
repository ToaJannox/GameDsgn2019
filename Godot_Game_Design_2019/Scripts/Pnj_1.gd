extends Area2D

func _on_Pnj_1_body_entered(body):
	if body.name == "Player":
		$"Texte Pnj 1".show()

func _on_Pnj_1_body_exited(body):
	if body.name == "Player":
		$"Texte Pnj 1".hide()
