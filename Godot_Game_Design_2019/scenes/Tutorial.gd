extends RichTextLabel

var tuto_dialog = ["Appuyez sur les touches de directions gauches et droites afin de vous deplacer.", 
					"Bien ! Testez la barre d'espace maintenant.", 
					"Quel joli saut !"]
var page_dialog = 0
var page = 0

var finish = false
var start = false

var change_wait = false
var wait = 0

func _ready():
	set_bbcode(tuto_dialog[page])
	set_visible_characters(0)
	set_process_input(true)

func _process(delta):
	set_bbcode(tuto_dialog[page])
	launch_tuto(0)

func launch_tuto(page):
	if get_visible_characters() > get_total_character_count():
		change_wait = true
		if wait == 20: 
			if page_dialog < tuto_dialog.size()-1:
				page_dialog += 1
				set_bbcode(tuto_dialog[page_dialog])
				set_visible_characters(0)
			elif page_dialog == tuto_dialog.size()-1:
				finish = true
			change_wait = false
			wait = 0

func _on_Timer_timeout():
	if start :
		if change_wait:
			wait = wait + 1
		set_visible_characters(get_visible_characters()+1)
