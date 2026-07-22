extends Node2D
var creds := false
var dict:={
	"retry": "Reiniciar",
	"quit": "Quitar",
	"back": "Voltar",
	"settings": "Configurações",
	"grid": "Opacidade da Grade",
	"volume": "Volume",
	"language": "Idioma",
	"loading": "Carregando",
	"stats": "Status",
	"hunger": "Fome",
	"sleep": "Sono",
	"water": "Hidratação",
	"credits": "[b]Trago por:\n[/b][i]Seni - Raposa artisa\nKs - Cão autista\n[/i]\n[b] Playtesters:[/b] [i] \nRokabane \n[manda seu user \npara adição]\n[/i]\n[b] Traduções:[/b] [i] \nShavian: Ks \nPortuguês: Ks \nEspanhol: Billy \nFrançes: Billy \nFinlandês: Billy \nBraille: Ks \n[/i]  \n[b] Música: [/b] \n[i] DOododoDodOd\n- Ks\n[/i] \n[b] Obrigados: [/b][i] \nEge\nRay\nVali!\nRokabane\nBilly\nHackclub\nGodot Forum\nMeu Laptop de 7 anos\nMatemática5\n\n\nVOCÊ!\n[/i]",
	"y1": 'Sim',
	"y2": 'Tá',
	"y3": 'Claro',
	"n1": 'Nah',
	"n2": 'Não',
	"n3": 'Nã',
	"w1": 'Quê?',
	"w2": 'Huh?',
	"w3": 'Ãh?',
	"dots": '...',

	"L": "Lavender",
	"S": "Soap",
	"P": "Petal",
	"WB": "Winterblush",
	"Y": "Yellow",
	"Ch": "Charcoal",
	"Sn": "Seni",
	"Ks": "Ks",

	"Status": "Status",
	"Thirsty": "Sede",
	"Hungry": "Fome",
	"Eepy": "Sonin",
	"Sleepy": "Sono",
	"Dizzy": "AAAAAAA",

	"0-0": '"Minhas pobres flores..."',
	"0-1": '"Você está no seu quarto, está tudo bem, só um pouco assustada... Talvez devesse olhar como seu irmão está."',

	"1-0": '"Ei Lavender... Você parece assustada... Você está bem?"',
	"1-1": '"É... eu estou bem, só dormi tarde..."',
	"1-2": '"Você dormiu umas 9... mais cedo não dá"',
	"1-3": '"Não, Eu... não estou bem."',
	"1-4": '"Ei...Eu estou aqui, o que foi?"',
	"1-5": '"...Eu tive um sonho que eu estava cuidando das flores, e ai... uma delas secou e a mãe ficou brava..."',
	"1-6": '"Eu sinto muito, Lavender...Eu...queria poder te ajudar...A mãe está ficando mais frustrada esses dias..."',
	"1-7": '"É...obrigado por estar aqui."',
	"1-8": '"Um...bem, acha que eu deveria se inscrever? Eu estou um pouco indeciso aqui."',
	"1-9": '"Claro, por que não?"',
	"1-10": '"Sério? Você realmente acha que eu sou tão forte e atlético pra se inscrever?"',
	"1-11": 'Você ri.',
	"1-12": '"Hum...não tanto."',
	"1-13": '"Justo, duvido que a mãe fosse me inscrever de qualquer forma."',
	"1-14": '"Ela provavelmente inscreverá Winter"',
	"1-15": 'Você afirma',
	"1-16": '"Talvez eu possa ir?"',
	"1-17": '"Duvido...É tipo um acampamento...exceto que com mais competição"',
	"1-18": '"É uma competição Lavender. Você não gosta muito de competições"',
	"1-19": 'Você diz nada, mas é verd-',
	"1-20": 'Você ouve o barulho do portão abrindo',
	"1-21": 'Melhor dormimos logo. Não queremos ela brava.',

	"2-0": '"Eu não acredito que tudo deu errado no show. As luzes, o microfene, os acordes, o público..."',
	"2-1": '"Tudo está arruinando o concerto."',
	"2-2": '"...Eu também esperava mais de tu, Winterblush."',
	"2-3": '"É claro que você esperava... nada está bom o suficiente para você, Petal."',
	"2-4": '"Quando será o bastante pra você?"',
	"2-5": '"Só será suficiente quando for exato, polido, perfeito! Tu não entenderias"',
	"2-6": '"Eu estou dando o meu melhor, e ainda assim não é suficiente."',
	"2-7": '"Se você quer elas tããããão perfeitas, podia botar um pouco de alma nelas, soam muito robóticas."',
	"2-8": '"Até o uniforme é chato, eu pareço uma boneca."',
	"2-9": '"...O que foi que tu disse?"',
	"2-10": '"Não se atreva a criticar o trabalho de sua mãe, é graças a ele que tu tens comida e abrigo."',
	"2-11": '"É gRaçAs a eLe Que tu tENs coMiDa e aBriGo."',
	"2-12": '"Você sabe muito bem que a maior parte do dinheiro vem das mercadorias."',
	"2-13": '"Dinheiro é dinheiro, querida, eu estou fazendo o que posso pra cuidar de vocês. Se não é bom o suficiente, então como eu deveria mimá-los?"',
	"2-14": '"Tu és a filha mais preciosa que eu tenho, e você sabe disso. Não me faça ter que te odiar."',
	"2-15": '"E? Um dia você vai ver por que todo mundo te abandonou."',
	"2-16": '"Como se fosse acontecer!, Eu tenho uma otima reputação Winterblush. Isso não vai ocorrer tão cedo."',
	"2-17": '"...Mal posso esperar fugir daqui."',

	"3-0": 'Você acorda, cansada. Pelo menos o sonho esta noite não foi tão assustador',
	"3-1": 'Você vê Winterblush do seu lado, que não conseguiu dormir',
	"3-2": '"Pelo menos você dormiu bem né?"',
	"3-3": '"Eu tive que lidar com a Petal e os shows dela. Fui uma das cantoras."',
	"3-4": '"Como eu odeio minha voz, no ultimo show eu não consegui cantar e a Petal surtou, depois me ignorou, e ainda veio brava pra casa."',
	"3-5": '"Olha... Se você não for cuidadosa com ela, quem sabe o que aconteceria?"',
	"3-6": '"É melhor ir buscar o correio, Lavvy"',
	"3-7": '"Okay..."',
	"3-8": '"O que acontece?"',
	"3-9": '"Certeza que logo saberá exatamente o que acontece."',
	"3-10": '"Você deveria ir logo pegar o correio Lavvy."'
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	FileAccess.open("res://images/lang/port.txt",FileAccess.WRITE).store_string(var_to_str(dict)) #aaaaaaaaaaaaaaaaaaaaaaaaa
	$cred.text = str_to_var(FileAccess.open(Global.lan[Global.lang],FileAccess.READ).get_as_text().replace("\t", "")).credits #aaaaaaaaaaaaaaaaaaaaaaaaa
	if $play.button_pressed:
		get_tree().change_scene_to_file("res://level_3.tscn")
	if $settings.button_pressed:
		Global.toggle = true
	if $credits.button_pressed:
		creds = true
	if creds:
		if $cred.position.y < -4700:
			creds = false
			$cred.position.y = 500
		else:
			$cred.position.y -= 6
	if creds or Global.toggle:$ColorRect.visible = 1
	else:$ColorRect.visible = 0
