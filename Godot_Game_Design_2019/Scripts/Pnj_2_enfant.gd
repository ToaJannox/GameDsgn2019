extends Area2D

var is_passed = false
var Fox_passed = false

func _on_Pnj_2_enfant_body_entered(body):
	if body.name == "Fox":
		Fox_passed = true
		$AnimatedSprite.animation = "point"
		$AnimatedSprite.flip_h = true
		$"Texte Pnj 2/Call_Hana".hide()
		$"Texte Pnj 2/Say_Pet_Dir".hide()
		$"Texte Pnj 2/See_Fox".show()
	if body.name == "Player":
		is_passed = true
		$"Texte Pnj 2".show()
		if !Fox_passed && !is_passed:
			$AnimatedSprite.animation = "static"
			$"Texte Pnj 2/Call_Hana".show()
			$"Texte Pnj 2/Say_Pet_Dir".hide()
			$"Texte Pnj 2/See_Fox".hide()
		elif !Fox_passed:
			$AnimatedSprite.animation = "point"
			$AnimatedSprite.flip_h = false
			$"Texte Pnj 2/Call_Hana".hide()
			$"Texte Pnj 2/Say_Pet_Dir".show()
			$"Texte Pnj 2/See_Fox".hide()


func _on_Pnj_2_enfant_body_exited(body):
	if body.name == "Player":
		$"Texte Pnj 2".hide()
		$"Texte Pnj 2/Call_Hana".hide()
		$"Texte Pnj 2/Say_Pet_Dir".hide()
		$"Texte Pnj 2/See_Fox".hide()
