extends RichTextLabel

var tuto_walk = ["Bienvenue dans le jeu Shades !",
			"Voici Hana, jeune fille du village, je vous l'aurais bien présentée un peu plus mais pour le moment vous devez l'aider à récuperer son doudou",
			"Première étape : utilisez les touches directionnelles pour vous déplacez"]
			
var tuto_jump = ["moment de sauter"]

var tuto = [tuto_walk, tuto_jump]
			
var wich_tuto
var page_tuto
var cur_page

var finish = false
var start = false
var setted = false

var change_wait = false
var wait = 0

func _ready():
	wich_tuto = 0
	set_tuto()
	set_process_input(true)
	
func set_tuto():
	cur_page = 0
	page_tuto = cur_page
	print(tuto[wich_tuto][page_tuto])
	set_bbcode(tuto[wich_tuto][page_tuto])
	set_visible_characters(0)
	setted = true

func _process(delta):
	if get_visible_characters() > get_total_character_count():
		change_wait = true
		if wait == 1000 || Input.is_action_just_pressed("ui_accept"): 
			if cur_page < tuto[wich_tuto].size()-1:
				print("change")
				cur_page += 1
				page_tuto = cur_page
				set_bbcode(tuto[wich_tuto][page_tuto])
				set_visible_characters(0)
			elif cur_page >= tuto[wich_tuto].size()-1:
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
