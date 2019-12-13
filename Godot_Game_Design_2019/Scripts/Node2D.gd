extends Node2D

var level

func _process(delta):
	level = get_node("Player").level
	print("level = ", level)
	
	setLevel()
	
	var canvas = get_node("Visibilité")
	var pet = get_node("Pet")
	if pet.activated:
		canvas.set_color(Color(0.3, 0.3, 0.3))
	pass # Replace with function body.

func setLevel():
	var player = $Player
	
	if level == 1:
		var x = $"Start 1_1".position.x
		var y = $"Start 1_1".position.y
		player.position.x = x
		player.position.y = y
		player.level = 0;
		
	if level == 1.2:
		var x = $"Start 1_2".position.x
		var y = $"Start 1_2".position.y
		player.position.x = x
		player.position.y = y
		player.level = 0;
