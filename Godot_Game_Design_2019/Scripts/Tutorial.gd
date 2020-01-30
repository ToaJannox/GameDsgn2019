extends Polygon2D

func launch_tuto(page_tuto):
	Player.playerControlled = false
	$Tutorial_text.page_tuto = page_tuto
		
	show()
	$Tutorial_text.start = true
	if $Tutorial_text.finish :
		print("end")
		$Timer.stop()
		hide()
		Player.launch_tuto = false
		Player.playerControlled = true
