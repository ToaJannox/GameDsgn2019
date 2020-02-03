extends RichTextLabel

var enter_1_2 = ["Mais, comment je vais remonter tout ça moi ?", "Et mon doudou !"]

var dialog = [enter_1_2]

var wich_dialog
var page
var cur_page

var finish = false
var start = false
var setted = false

var change_wait = false
var wait = 0

func _ready():
	wich_dialog = 0
	set_tuto()
	set_process_input(true)
	
func set_tuto():
	cur_page = 0
	page = cur_page
	set_bbcode(dialog[wich_dialog][page])
	set_visible_characters(0)
	setted = true

func _process(delta):
	if get_visible_characters() > get_total_character_count():
		change_wait = true
		print(finish)
		if wait == 1000 || Input.is_action_just_pressed("ui_accept"): 
			if cur_page < dialog[wich_dialog].size()-1:
				print("change")
				cur_page += 1
				page = cur_page
				set_bbcode(dialog[wich_dialog][page])
				set_visible_characters(0)
			elif cur_page >= dialog[wich_dialog].size()-1:
				print("end")
				finish = true
				setted = false
			change_wait = false
			wait = 0
	elif get_visible_characters() > 0:
		if Input.is_action_pressed("ui_up"):
			set_visible_characters(get_total_character_count())

func _on_Timer_timeout():
	if start :
		if change_wait:
			wait = wait + 1
		set_visible_characters(get_visible_characters()+1)

