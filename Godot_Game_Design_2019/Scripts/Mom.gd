extends Area2D

var is_launch = false
var is_passed = false
var page = 0

func _process(delta):
	if is_launch && !is_passed:
		launch_girl_speak(page)
	
func launch_girl_speak(page):
	if !$Polygon2D/Text_Mom.finish :
		Player.playerControlled = false
		$Polygon2D/Text_Mom.page = page
		
		if page > 0 && !$Polygon2D/Text_Mom.setted:
			$Polygon2D/Text_Mom.set_dialog()
			$Timer.start()
		
		$Polygon2D.show()
		$Polygon2D/Text_Mom.start = true
	else:
		is_launch = false
		$Polygon2D/Timer.stop()
		$Polygon2D.hide()
		Player.playerControlled = true
		$Polygon2D/Text_Mom.finish = false
		is_passed = true

func _on_Mom_body_entered(body):
	if body.name == "Player":
		is_launch = true
		page = 0