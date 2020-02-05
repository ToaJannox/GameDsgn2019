extends Area2D

func _on_Disable_collision_Fox_body_entered(body):
	if body.name == "Fox":
		print("mlalalaa")
		$Caisses/Collsisions_Caisses.disabled = true


func _on_Disable_collision_Fox_body_exited(body):
	if body.name == "Fox":
		$Caisses/Collsisions_Caisses.disabled = false
