extends Area2D

var body_on = false

func _process(delta):
	if body_on:
		if Input.is_action_just_pressed("ui_accept"):
			$"Text_Action_Panneau".hide()
			$"Text_Panneau".show()

func _on_Panneau_body_entered(body):
	if body.name == "Player":
		$"Text_Action_Panneau".show()
		body_on = true


func _on_Panneau_body_exited(body):
	if body.name == "Player":
		$"Text_Action_Panneau".hide()
		$"Text_Panneau".hide()
		body_on = false
