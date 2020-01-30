extends RichTextLabel

var tuto_walk = ["Bienvenue dans le jeu Shades ! Dans ce tutoriel vous allez apprendre les bases des commandes du jeu, tout d'abord, utilisez les touches directionnelles pour vous déplacez"]
var tuto_jump = ["Des caisses vous bloquent la route, appuyez sur la flèche du haut pour sauter et pouvoir passer de l'autre côté"]

var tuto = [tuto_walk, tuto_jump]

var page_tuto = 0 # wich tuto

var finish = false
var start = false

var change_wait = false
var wait = 0

func _ready():
	set_bbcode(tuto[page_tuto][0])
	set_visible_characters(0)
	set_process_input(true)

func _process(delta):
	if get_visible_characters() > get_total_character_count():
		change_wait = true
		if wait == 200 || Input.is_action_just_pressed("ui_accept"): 
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
