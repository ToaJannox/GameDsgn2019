extends Node

func Ladder_body_entered(body):
	if body.name == "Player":
		Player.on_ladder = true;
		
func Ladder_body_exited(body):
	if body.name == "Player":
		Player.on_ladder = false;
		

func _on_Ladder_1_body_entered(body):
	Ladder_body_entered(body)

func _on_Ladder_1_body_exited(body):
	Ladder_body_exited(body)


func _on_Ladder_2_body_entered(body):
	Ladder_body_entered(body)

func _on_Ladder_2_body_exited(body):
	Ladder_body_exited(body)


func _on_Ladder_3_body_entered(body):
	Ladder_body_entered(body)

func _on_Ladder_3_body_exited(body):
	Ladder_body_exited(body)


func _on_Ladder_4_body_entered(body):
	Ladder_body_entered(body)

func _on_Ladder_4_body_exited(body):
	Ladder_body_exited(body)
