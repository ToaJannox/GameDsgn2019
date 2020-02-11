extends RichTextLabel

var tuto_walk = ["Bienvenue dans le jeu Shades !",
			"Voici Hana, jeune fille du village, je vous l'aurais bien présentée un peu plus mais pour le moment vous devez l'aider à récuperer son doudou",
			"Première étape : utilisez les touches directionnelles gauche et droite pour vous déplacez"]
			
var tuto_jump = ["Des caisses vous barrent la route", "Appuyez sur la flèche directionnelle du haut pour sauter"]

var end_demo = ["Vous voici à l'emplacement de la dinette", "Dans Shades, chaque niveau se fini ici et vous permettra de sauvegarder.",
			"Cet endroit est la fin de la démo, merci d'y avoir joué !"]
			
var tuto_pet_fly = ["Vous venez de récupérer le doudou d'Hana", "Il a l'air d'avoir gagné des pouvoirs étranges, appuyez sur la touche \"F\" pour le controler"]

var tuto = [tuto_walk, tuto_jump, end_demo, tuto_pet_fly]
			
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
	setted = false
	set_process_input(true)
	
func set_tuto():
	cur_page = 0
	page_tuto = cur_page
	set_bbcode(tuto[wich_tuto][page_tuto])
	print(tuto[wich_tuto][page_tuto])
	set_visible_characters(0)
	setted = true

func _process(delta):
	if start :
		if get_visible_characters() > get_total_character_count():
			change_wait = true
			if wait == 1000 || Input.is_action_just_pressed("ui_accept"): 
				if cur_page < tuto[wich_tuto].size()-1:
					cur_page += 1
					page_tuto = cur_page
					set_bbcode(tuto[wich_tuto][page_tuto])
					set_visible_characters(0)
				elif cur_page >= tuto[wich_tuto].size()-1:
					setted = false
					finish = true
				change_wait = false
				wait = 0
		elif get_visible_characters() > 0:
			if Input.is_action_pressed("ui_up"):
				set_visible_characters(get_total_character_count())

func _on_Timer_timeout():
	if change_wait:
		wait = wait + 1
	set_visible_characters(get_visible_characters()+1)
