extends Polygon2D

func launch_girl_speak(page):
	position.x = Player.get_node("Camera2D_Player").get_camera_position().x - Player.position.x
	# keep his y position
	if !$TextGirl.finish :
		Player.playerControlled = false
		$TextGirl.wich_dialog = page
		
		if page > 0 && !$TextGirl.setted:
			$TextGirl.set_tuto()
			$Timer.start()
		
		show()
		$TextGirl.start = true
	else:
		$Timer.stop()
		hide()
		Player.launch_dialog = false
		Player.playerControlled = true
		$TextGirl.finish = false