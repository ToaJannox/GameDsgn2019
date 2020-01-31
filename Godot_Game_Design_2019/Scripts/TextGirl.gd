extends RichTextLabel

var dialog_enter_1_2 = ["Mais, comment je vais remonter tout ça moi ?", "Et mon doudou !", "aled"]
var page_enter_1_2 = 0

var finish = false
var start = false

var change_wait = false
var wait = 0

func _ready():
	set_bbcode(dialog_enter_1_2[page_enter_1_2])
	set_visible_characters(0)
	set_process_input(true)

func _process(delta):
	if get_visible_characters() > get_total_character_count():
		change_wait = true
		if wait == 30 || Input.is_action_just_pressed("ui_accept"): 
			if page_enter_1_2 < dialog_enter_1_2.size()-1:
				page_enter_1_2 += 1
				set_bbcode(dialog_enter_1_2[page_enter_1_2])
				set_visible_characters(0)
			elif page_enter_1_2 == dialog_enter_1_2.size()-1:
				finish = true
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
