extends Area2D

var Fox_passed = false

func _process(delta):
	$AnimatedSprite.animation = "default"

func _on_Pnj_1_body_entered(body):
	if body.name == "Player":
		$"Texte Pnj 1".show()
		if !Fox_passed :
			$"Texte Pnj 1/Text_girl_not_fox".show()
			$"Texte Pnj 1/Text_girl_fox".hide()
		else:
			$"Texte Pnj 1/Text_girl_fox".show()
			$"Texte Pnj 1/Text_girl_not_fox".hide()
	if body.name == "Fox":
		Fox_passed = true

func _on_Pnj_1_body_exited(body):
	if body.name == "Player":
		$"Texte Pnj 1".hide()
