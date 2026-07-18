extends Node2D
var creds := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$cred.text = \
	(["[b]Brought by:\n[/b][i]Seni - The art fox\nKs - The autism dog\n[/i]\n[b] Playtesters:[/b] [i] \nRokabane \n[send your name \nso i can add]\n[/i]\n[b] Translations:[/b] [i] \nShavian: Ks \nPortuguese: Ks \nSpanish: Billy \nFrench: Billy \nFinnish: Billy \n[/i] \n[b] Music: [/b] \n[i] DOododoDodOd\n- Ks\n[/i] \n[b] Thank yous: [/b][i] \nEge\nRay\nVali!\nRokabane\nBilly\nHackclub\nGodot Forum\nMy 7 year old laptop\nMath5\n\n\nYOU!\n[/i]",\
	"[b]Trago por:\n[/b][i]Seni - Raposa artisa\nKs - Cão autista\n[/i]\n[b] Playtesters:[/b] [i] \nRokabane \n[manda seu user \npara adição]\n[/i]\n[b] Traduções:[/b] [i] \nShavian: Ks \nPortuguês: Ks \nEspanhol: Billy \nFrançes: Billy \nFinlandês: Billy \n[/i]  \n[b] Música: [/b] \n[i] DOododoDodOd\n- Ks\n[/i] \n[b] Obrigados: [/b][i] \nEge\nRay\nVali!\nRokabane\nBilly\nHackclub\nGodot Forum\nMeu Laptop de 7 anos\nMatemática5\n\n\nVOCÊ!\n[/i]",\
	"[b]𐑚𐑮𐑷𐑑 𐑚𐑲:\n[/b][i]·𐑕𐑧𐑯𐑦 - 𐑞 𐑸𐑑 𐑓𐑪𐑒𐑕\n·𐑒𐑧𐑟 - 𐑞 𐑷𐑑𐑦𐑟𐑩𐑥 𐑛𐑪𐑜\n[/i]\n[b] 𐑐𐑤𐑱𐑑𐑧𐑕𐑑𐑼𐑟:[/b] [i] \n·𐑮𐑪𐑒𐑨𐑚𐑨𐑥𐑧 \n[𐑕𐑧𐑯𐑛 𐑿𐑼 𐑯𐑱𐑥 \n𐑕𐑴 𐑲 𐑒𐑨𐑯 𐑨𐑛]\n[b] 𐑑𐑮𐑨𐑯𐑟𐑤𐑱𐑖𐑩𐑯𐑟:[/b] [i] \n 𐑖𐑱𐑝𐑾𐑯: ·𐑒𐑧𐑟 \n 𐑐𐑹𐑗𐑩𐑜𐑰𐑟: ·𐑒𐑧𐑟 \n 𐑕𐑐𐑨𐑯𐑦𐑖:·𐑚𐑦𐑤𐑦  \n 𐑓𐑮𐑧𐑯𐑗: ·𐑚𐑦𐑤𐑦 \n 𐑓𐑦𐑯𐑦𐑖: ·𐑚𐑦𐑤𐑦 \n[/i]\n[/i] \n[b] 𐑥𐑿𐑟𐑦𐑒: [/b] \n[i] \nDOododoDodOd- ·𐑒𐑧𐑟\n[/i] \n[b] 𐑔𐑨𐑙𐑒 𐑿𐑟: [/b][i] \n·𐑧𐑜𐑧\n·𐑮𐑱\n·𐑝𐑨𐑤𐑦!\n·𐑮𐑪𐑒𐑨𐑚𐑨𐑥𐑧\n·𐑚𐑦𐑤𐑦\n𐑣𐑨𐑒𐑒𐑤𐑳𐑚\n𐑜𐑩𐑛𐑴𐑑 𐑓𐑹𐑩𐑥\n𐑥𐑲 7 𐑘𐑽 𐑴𐑤𐑛 𐑤𐑨𐑐𐑑𐑪𐑐\n𐑥𐑨𐑔\n\n\n𐑿!\n[/i]",\
	"[b]Creado por:\n[/b][i]Seni - El zorro artista\nKs - El perro autista\n[/i]\n[b] Playtesters:[/b] [i] \nRokabane \n[envía tu nombre \npara agregarte]\n[/i]\n[b] Traducciones:[/b] [i] \nShavian: Ks \nPortugués: Ks \nEspañol: Billy \nFrancés: Billy \nFinlandés: Billy \n[/i] \n[b] Música: [/b] \n[i] DOododoDodOd\n- Ks\n[/i] \n[b] Agradecimientos: [/b][i] \nEge\nRay\nVali!\nRokabane\nBilly\nHackclub\nGodot Forum\nMi laptop de 7 años\nMath5\n\n\n¡TÚ!\n[/i]",\
	"[b]Créé par:\n[/b][i]Seni - Le renard artiste\nKs - Le chien autiste\n[/i]\n[b] Playtesters:[/b] [i] \nRokabane \n[envoie ton nom \npour l'ajouter]\n[/i]\n[b] Traductions:[/b] [i] \nShavian : Ks \nPortugais : Ks \nEspagnol : Billy \nFrançais : Billy \nFinnois : Billy \n[/i] \n[b] Musique: [/b] \n[i] DOododoDodOd\n- Ks\n[/i] \n[b] Remerciements: [/b][i] \nEge\nRay\nVali!\nRokabane\nBilly\nHackclub\nGodot Forum\nMon PC portable de 7 ans\nMath5\n\n\nTOI!\n[/i]",\
	"[b]Tekijät:\n[/b][i]Seni - Taiteilijakettu\nKs - Autistinen koira\n[/i]\n[b] Testaajat:[/b] [i] \nRokabane \n[lähetä nimesi \njotta voin lisätä]\n[/i]\n[b] Käännökset:[/b] [i] \nShavian: Ks \nPortugali: Ks \nEspanja: Billy \nRanska: Billy \nSuomi: Billy \n[/i] \n[b] Musiikki: [/b] \n[i] DOododoDodOd\n- Ks\n[/i] \n[b] Kiitokset: [/b][i] \nEge\nRay\nVali!\nRokabane\nBilly\nHackclub\nGodot Forum\n7 vuotta vanha läppärini\nMath5\n\n\nSINÄ!\n[/i]",\
	"[b]⠠⠃⠗⠕⠥⠛⠓⠞ ⠃⠽⠒\n[/b][i]⠠⠎⠑⠝⠊ ⠤ ⠠⠞⠓⠑ ⠁⠗⠞ ⠋⠕⠭\n⠠⠒⠎ ⠤ ⠠⠞⠓⠑ ⠁⠥⠞⠊⠎⠍ ⠙⠕⠛\n[/i]\n[b] ⠠⠏⠤⠁⠽⠞⠑⠎⠞⠑⠗⠎⠒[/b] [i] \n⠠⠗⠕⠅⠁⠃⠁⠝⠑ \n[⠎⠑⠝⠙ ⠽⠕⠥⠗ ⠝⠁⠍⠑ \n⠎⠕ ⠊ ⠉⠁⠝ ⠁⠙⠙]\n[/i]\n[b] ⠠⠞⠗⠁⠝⠎⠤⠁⠞⠊⠕⠝⠎⠒[/b] [i] \n⠠⠎⠓⠁⠧⠊⠁⠝⠒ ⠠⠒⠎ \n⠠⠏⠕⠗⠞⠥⠛⠥⠑⠎⠑⠒ ⠠⠒⠎ \n⠠⠎⠏⠁⠝⠊⠎⠓⠒ ⠠⠃⠊⠇⠇⠽ \n⠠⠓⠗⠑⠝⠉⠓⠒ ⠠⠃⠊⠇⠇⠽ \n⠠⠓⠊⠝⠝⠊⠎⠓⠒ ⠠⠃⠊⠇⠇⠽ \n[/i] \n[b] ⠠⠍⠥⠎⠊⠉⠒ [/b] \n[i] ⠠⠙⠕⠕⠙⠕⠙⠕⠠⠙⠕⠙⠠⠕⠙\n⠤ ⠠⠒⠎\n[/i] \n[b] ⠠⠞⠓⠁⠝⠅ ⠽⠕⠥⠎⠒ [/b][i] \n⠠⠑⠛⠑\n⠠⠗⠁⠽\n⠠⠧⠁⠇⠊⠄\n⠠⠗⠕⠅⠁⠃⠁⠝⠑\n⠠⠚⠊⠇⠇⠽\n⠠⠓⠁⠉⠅⠉⠤⠥⠃\n⠠⠛⠕⠙⠕⠞ ⠠⠋⠕⠗⠥⠍\n⠠⠍⠽ ⠼⠛ ⠽⠑⠁⠗ ⠕⠇⠙ ⠇⠁⠏⠞⠕⠏\n⠠⠍⠁⠞⠓⠼⠑\n\n\n⠠⠽⠕⠥⠄\n[/i]"])\
	[Global.lang]
	if $play.button_pressed:
		get_tree().change_scene_to_file("res://level_3.tscn")
	if $settings.button_pressed:
		Global.toggle = true
	if $credits.button_pressed:
		creds = true
	if creds:
		if $cred.position.y < -4400:
			creds = false
			$cred.position.y = 500
		else:
			$cred.position.y -= 6
	if creds or Global.toggle:$ColorRect.visible = 1
	else:$ColorRect.visible = 0
