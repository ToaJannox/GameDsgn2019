extends Polygon2D

func launch_tuto(page):
	position.x = Player.get_node("Camera2D_Player").get_camera_position().x - Player.position.x - 57
	#57 is x gap
	#keep his y position
	if !$Tutorial_text.finish :
		Player.playerControlled = false
		$Tutorial_text.wich_tuto = page
		
		if page > 0 && !$Tutorial_text.setted:
			$Tutorial_text.set_tuto()
			$Timer.start()
		
		show()
		$Tutorial_text.start = true
	else:
		$Tutorial_text.finish = false
		$Tutorial_text.start = false
		$Timer.stop()
		hide()
		Player.launch_tuto = false
		Player.playerControlled = true
