extends AudioStreamPlayer2D
var old_frame = 0
enum GROUND_TYPE {
	SAND,
	STONE
	}
var sounds

var currentGroundType = GROUND_TYPE.SAND

func _ready():
	match currentGroundType:
		GROUND_TYPE.SAND:
			sounds =  [
		preload("res://ressources/Sounds/player/steps/sand/sand1.wav"),
		preload("res://ressources/Sounds/player/steps/sand/sand2.wav"),
		preload("res://ressources/Sounds/player/steps/sand/sand3.wav"),
		preload("res://ressources/Sounds/player/steps/sand/sand4.wav"),
		preload("res://ressources/Sounds/player/steps/sand/sand5.wav")
		]
		GROUND_TYPE.STONE:
				sounds =  [
		preload("res://ressources/Sounds/player/steps/stone/stone1.wav"),
		preload("res://ressources/Sounds/player/steps/stone/stone2.wav"),
		preload("res://ressources/Sounds/player/steps/stone/stone3.wav"),
		preload("res://ressources/Sounds/player/steps/stone/stone4.wav"),
		preload("res://ressources/Sounds/player/steps/stone/stone5.wav"),
		]
		
	randomize()
	
		
func step():
	if(get_node("../PlayerSprite").animation=="walk")&&(get_node("..").is_on_floor()):
		stream = sounds[randi()% sounds.size()]
		play()
	
