extends Polygon2D

func launch_tuto(page_tuto):
	if !$Tutorial_text.finish :
		Player.playerControlled = false
		$Tutorial_text.wich_tuto = page_tuto
		
		if page_tuto > 0 && !$Tutorial_text.setted:
			$Tutorial_text.set_tuto()
			$Timer.start()
		
		show()
		$Tutorial_text.start = true
	else:
		print("end")
		$Timer.stop()
		hide()
		Player.launch_tuto = false
		Player.playerControlled = true
		$Tutorial_text.finish = false
