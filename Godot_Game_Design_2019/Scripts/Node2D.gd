extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _process(delta):
	var canvas = get_node("Visibilité")
	var pet = get_node("Pet")
	if pet.activated:
		canvas.set_color(Color(0.3, 0.3, 0.3))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
