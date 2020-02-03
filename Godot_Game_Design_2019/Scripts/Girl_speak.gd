extends Polygon2D

func launch_girl_speak(page):
	if !$TextGirl.finish :
		Player.playerControlled = false
		$TextGirl.page = page
		
		if page > 0 && !$TextGirl.setted:
			$TextGirl.set_tuto()
			$Timer.start()
		
		show()
		$TextGirl.start = true
	else:
		print("here")
		$Timer.stop()
		hide()
		Player.launch_dialog = false
		Player.playerControlled = true
		$TextGirl.finish = false