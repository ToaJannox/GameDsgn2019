extends AudioStreamPlayer2D
var old_frame = 0
var sounds = [
	preload("res://ressources/Sounds/player/steps/sand/sand1.wav"),
	preload("res://ressources/Sounds/player/steps/sand/sand2.wav"),
	preload("res://ressources/Sounds/player/steps/sand/sand3.wav"),
	preload("res://ressources/Sounds/player/steps/sand/sand4.wav"),
	preload("res://ressources/Sounds/player/steps/sand/sand5.wav")
	]
	
func _ready():
	randomize()
	
		
func step():
	if(get_node("../PlayerSprite").animation=="walk")&&(get_node("..").is_on_floor()):
		stream = sounds[randi()% sounds.size()]
		play()
	
