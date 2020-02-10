extends Area2D

var Fox_passed = false

func _on_Pnj_3_dame_body_entered(body):
	if body.name == "Player":
		$"Texte Pnj 3".show()
		if !Fox_passed:
			$"Texte Pnj 3/See_fox".hide()
			$"Texte Pnj 3/See_hana".show()
		else:
			$"Texte Pnj 3/See_fox".show()
			$"Texte Pnj 3/See_hana".hide()
	if body.name == "Fox":
		Fox_passed = true


func _on_Pnj_3_dame_body_exited(body):
	if body.name == "Player":
		$"Texte Pnj 3".hide()
		$"Texte Pnj 3/See_fox".hide()
		$"Texte Pnj 3/See_hana".hide()