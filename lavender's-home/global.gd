extends Node
#just adding this so i can make a repoaaaaaaaaaaaaaa
var lang := 1
var storystep = 3
var m1 = 1
var m2 = 1
var m3 = 1
var level := 1
var took_stairs := false
var talking := false
var mini_delay := 0.06
var full_delay := 0
var health := 100
var water := 100
var hunger := 100
var sleep := 100
var wiggle_delay = 4
var room_matrix := []
var special_matrix := []
var hurt_matrix := []
var cols = 17
var rows = 14
var GridT = 0.5
var goals := 0
var fgoals := 0
var toggle = false
var moves := 0
var clear = false
var Soap = [0,0]
var Card = [0]
var Petal = [0,0]
var Wb = [0,0]
var x := 0
var y := 0
var loading := false

var story:=[\
	#plan: 0-character(see list) 1-icon(see list) 2-text 3-number of buttons 4,6,8... button texts 5,7,9... button leads to step x
[[0] , [3,999,['"My poor wilted flowers..."','"Minhas pobres flores..."','"𐑥𐑲 𐑐𐑫𐑼 𐑢𐑦𐑤𐑑𐑦𐑛 𐑓𐑤𐑬𐑼𐑟..."'],0,999] , [5,0,['You are in your bedroom, you are ok, just pretty scared...maybe you should check on Soap.','"Você está no seu quarto, está tudo bem, só um pouco assustada... Talvez devesse olhar como seu irmão está."','"𐑿 𐑸 𐑦𐑯 𐑘𐑹 𐑚𐑧𐑛𐑮𐑵𐑥, 𐑿 𐑸 𐑴𐑒𐑱, 𐑡𐑳𐑕𐑑 𐑐𐑮𐑦𐑑𐑦 𐑕𐑒𐑺𐑛. 𐑥𐑱𐑚𐑰 𐑿 𐑖𐑫𐑛 𐑗𐑧𐑒 𐑪𐑯 𐑕𐑴𐑐"'],0,0]],\
[[1],[1,6,['"Hey Lavender, you look scared... are you...okay?"','"Ei Lavender... Você parece assustada... Você está bem?"','"𐑣𐑱 ·𐑤𐑨𐑝𐑩𐑯𐑛𐑼, 𐑿 𐑤𐑫𐑒 𐑕𐑒𐑺𐑛... 𐑸 𐑿...𐑴𐑒𐑱?"'],0,2],[0,6,'',2,['yea','sim','𐑘𐑱'],3,['no','não','𐑯𐑴'],8],[0,1,['"Yeah, I\'m alright. I just slept late..."','"É... eu estou bem, só dormi tarde..."','"𐑘𐑧𐑩, 𐑲𐑥 𐑷𐑤𐑮𐑲𐑑. 𐑲 𐑡𐑳𐑕𐑑 𐑕𐑤𐑧𐑐𐑑 𐑤𐑱𐑑..."'],0,4],[1,5,['"You slept at 9...the earliest you could\'ve slept..."','"Você dormiu umas 9... mais cedo não dá"','"𐑿 𐑕𐑤𐑧𐑐𐑑 𐑨𐑑 9... 𐑞 𐑻𐑤𐑦𐑩𐑕𐑑 𐑿 𐑒𐑫𐑛𐑝 𐑕𐑤𐑧𐑐𐑑..."'],0,5],[0,5,['"..."','"..."','"..."'],0,6],[1,5,['"..."','"..."','"..."'],0,7],[0,4,['"No, I\'m...not okay."','"Não, Eu... não estou bem."','"𐑯𐑴, 𐑲𐑥...𐑯𐑪𐑑 𐑴𐑒𐑱."'],0,8],[1,6,['"Hey...I\'m here for you, what\'s wrong?"','"Ei...Eu estou aqui, o que foi?"','"𐑣𐑱...𐑲𐑥 𐑣𐑽 𐑓 𐑿, 𐑢𐑪𐑑𐑕 𐑮𐑪𐑙?"'],0,9],[0,1,['"...I had a dream that I was taking care of the flowers, and then... one of them wilted and mother got mad..."','"...Eu tive um sonho que eu estava cuidando das flores, e ai... uma delas secou e a mãe ficou brava..."','"...𐑲 𐑣𐑨𐑛 𐑩 𐑛𐑮𐑰𐑥 𐑞𐑨𐑑 𐑲 𐑢𐑪𐑟 𐑑𐑱𐑒𐑦𐑙 𐑒𐑺 𐑝 𐑞 𐑓𐑤𐑬𐑼𐑟, 𐑯 𐑞𐑧𐑯... 𐑢𐑳𐑯 𐑝 𐑞𐑧𐑥 𐑢𐑦𐑤𐑑𐑦𐑛 𐑯 𐑥𐑳𐑞𐑼 𐑜𐑪𐑑 𐑥𐑨𐑛..."'],0,10],[1,2,['"I\'m so sorry, Lavender...I...wish I can help you. Mother is getting more frustrated lately..."','"Eu sinto muito, Lavender...Eu...queria poder te ajudar...A mãe está ficando mais frustrada esses dias..."','"𐑲𐑥 𐑕𐑴 𐑕𐑪𐑮𐑦, ·𐑤𐑨𐑝𐑩𐑯𐑛𐑼...𐑲...𐑢𐑦𐑖 𐑲 𐑒𐑨𐑯 𐑣𐑧𐑤𐑐 𐑿. 𐑥𐑳𐑞𐑼 𐑦𐑟 𐑜𐑧𐑑𐑦𐑙 𐑥𐑹 𐑓𐑮𐑳𐑕𐑑𐑮𐑱𐑑𐑦𐑛 𐑤𐑱𐑑𐑤𐑦..."'],0,11],[0,0,['"mhm...I\'m glad you\'re here."','"É...obrigado por estar aqui."','"𐑥𐑣𐑥...𐑲𐑥 𐑜𐑤𐑨𐑛 𐑿𐑼 𐑣𐑽."'],0,12],[1,5,['"..."','"..."','"..."'],0,13],[0,5,['"..."','"..."','"..."'],0,14],[1,6,['"Uhm...well, do you think i should sign up? I\'ve been skeptical of this thing for a bit."','"Um...bem, acha que eu deveria se inscrever? Eu estou um pouco indeciso aqui."','"𐑩𐑥...𐑢𐑧𐑤, 𐑛𐑵 𐑿 𐑔𐑦𐑙𐑒 𐑲 𐑖𐑫𐑛 𐑕𐑲𐑯 𐑳𐑐? 𐑲𐑝 𐑚𐑰𐑯 𐑕𐑒𐑧𐑐𐑑𐑦𐑒𐑩𐑤 𐑝 𐑞𐑦𐑕 𐑔𐑦𐑙 𐑓 𐑩 𐑚𐑦𐑑."'],0,15],[0,6,'',2,['Sure','Claro','𐑖𐑫𐑼'],16,['Nah','Nah','𐑯𐑨'],19],[0,0,['"Sure, why not?"','"Claro, por que não?"','"𐑖𐑫𐑼, 𐑢𐑲 𐑯𐑪𐑑?"'],0,17],[1,5,['"Really? You actually think I\'m that strong and athletic to sign up?"','"Sério? Você realmente acha que eu sou tão forte e atlético pra se inscrever?"','"𐑮𐑾𐑤𐑦? 𐑿 𐑨𐑒𐑗𐑩𐑤𐑦 𐑔𐑦𐑙𐑒 𐑲𐑥 𐑞𐑨𐑑 𐑕𐑑𐑮𐑪𐑙 𐑯 𐑨𐑔𐑤𐑧𐑑𐑦𐑒 𐑑 𐑕𐑲𐑯 𐑳𐑐?"'],0,18],[5,0,['You laugh slightly.','Você ri.','𐑿 𐑤𐑨𐑓 𐑕𐑤𐑲𐑑𐑤𐑦.'],0,23],[0,5,['"Hmmm...not really."','"Hum...não tanto."','"𐑥...𐑯𐑪𐑑 𐑮𐑾𐑤𐑦."'],0,20],[1,5,['"That\'s fair, I doubt mom would sign me up anyway."','"Justo, duvido que a mãe fosse me inscrever de qualquer forma."','"𐑞𐑨𐑑𐑕 𐑓𐑺, 𐑲 𐑛𐑬𐑑 𐑥𐑪𐑥 𐑢𐑫𐑛 𐑕𐑲𐑯 𐑥𐑰 𐑳𐑐 𐑧𐑯𐑦𐑢𐑱."'],0,21],[1,5,['"She\'ll probably sign Winter instead."','"Ela provavelmente inscreverá Winter"','"𐑖𐑰𐑤 𐑐𐑮𐑪𐑚𐑩𐑚𐑤𐑦 𐑕𐑲𐑯 ·𐑢𐑦𐑯𐑑𐑼 𐑦𐑯𐑕𐑑𐑧𐑛."'],0,22],[5,5,['You nod slightly','Você afirma','𐑿 𐑯𐑪𐑛 𐑕𐑤𐑲𐑑𐑤𐑦'],0,23],[0,6,['"Maybe I could go?"','"Talvez eu possa ir?"','"𐑥𐑱𐑚𐑰 𐑲 𐑒𐑫𐑛 𐑜𐑴?"'],0,24],[1,5,['"I doubt...It\'s like a camp...except with more competition."','"Duvido...É tipo um acampamento...exceto que com mais competição"','"𐑲 𐑛𐑬𐑑...𐑦𐑑𐑕 𐑤𐑲𐑒 𐑩 𐑒𐑨𐑥𐑐...𐑧𐑒𐑕𐑧𐑐𐑑 𐑢𐑦𐑞 𐑥𐑹 𐑒𐑪𐑥𐑐𐑧𐑑𐑦𐑖𐑩𐑯."'],0,25],[1,4,['"It\'s a competition, Lavender. You don\'t like competitions."','"É uma competição Lavender. Você não gosta muito de competições"','"𐑦𐑑𐑕 𐑩 𐑒𐑪𐑥𐑐𐑧𐑑𐑦𐑖𐑩𐑯, ·𐑤𐑨𐑝𐑩𐑯𐑛𐑼. 𐑿 𐑛𐑴𐑯𐑑 𐑤𐑲𐑒 𐑒𐑪𐑥𐑐𐑧𐑑𐑦𐑖𐑩𐑯𐑟."'],0,26],[5,5,['You say nothing, but it\'s tru-','Você diz nada, mas é verd-','𐑿 𐑕𐑱 𐑯𐑳𐑔𐑦𐑙, 𐑚𐑳𐑑 𐑦𐑑𐑕 𐑑𐑮𐑵-'],0,27],[5,2,['You hear the sound of the door opening','Você ouve o barulho do portão abrindo','𐑿 𐑣𐑽 𐑞 𐑕𐑬𐑯𐑛 𐑝 𐑞 𐑛𐑹 𐑴𐑐𐑩𐑯𐑦𐑙'],0,28],[1,5,['"We should sleep now. we don\'t want mother to get enraged','Melhor dormimos logo. Não queremos ela brava.','"𐑢𐑰 𐑖𐑫𐑛 𐑕𐑤𐑰𐑐 𐑯𐑬. 𐑢𐑰 𐑛𐑴𐑯𐑑 𐑢𐑪𐑯𐑑 𐑥𐑳𐑞𐑼 𐑑 𐑜𐑧𐑑 𐑧𐑯𐑮𐑱𐑡𐑛"'],0,0]],\
[[2], [3,1,['"I can not believe everything went so wrong with that show. The lights, the microphone, the chords, the crowd..."','"Eu não acredito que tudo deu errado no show. As luzes, o microfene, os acordes, o público..."','"𐑲 𐑒𐑨𐑯 𐑯𐑪𐑑 𐑚𐑦𐑤𐑰𐑝 𐑧𐑝𐑮𐑦𐑔𐑦𐑙 𐑢𐑧𐑯𐑑 𐑕𐑴 𐑮𐑪𐑙 𐑢𐑦𐑞 𐑞𐑨𐑑 𐑖𐑴. 𐑞 𐑤𐑲𐑑𐑕, 𐑞 𐑥𐑲𐑒𐑮𐑴𐑓𐑴𐑯, 𐑞 𐑒𐑹𐑛𐑟, 𐑞 𐑒𐑮𐑬𐑛..."'],0,2],[3,3,['"Everything is ruining the concert."','"Tudo está arruinando o concerto."','"𐑧𐑝𐑮𐑦𐑔𐑦𐑙 𐑦𐑟 𐑮𐑵𐑦𐑯𐑦𐑙 𐑞 𐑒𐑪𐑯𐑕𐑻𐑑."'],0,3],[3,4,['"...I also expected better from you, Winterblush."','"...Eu também esperava mais de tu, Winterblush."','"...𐑲 𐑷𐑤𐑕𐑴 𐑦𐑒𐑕𐑐𐑧𐑒𐑑𐑦𐑛 𐑚𐑧𐑑𐑻 𐑓𐑮𐑪𐑥 𐑿, ·𐑢𐑦𐑯𐑑𐑼𐑚𐑤𐑳𐑖."'],0,4],[2,4,['"Of course you do... nothing is ever good enough for you, Petal."','"É claro que você esperava... nada está bom o suficiente para você, Petal."','"𐑝 𐑒𐑹𐑕 𐑿 𐑛𐑵... 𐑯𐑳𐑔𐑦𐑙 𐑦𐑟 𐑧𐑝𐑼 𐑜𐑫𐑛 𐑦𐑯𐑳𐑓 𐑓𐑹 𐑿, ·𐑐𐑧𐑑𐑩𐑤."'],0,5],[2,4,['"When will it ever be enough for you?"','""Quando será o bastante pra você?','"𐑢𐑧𐑯 𐑢𐑦𐑤 𐑦𐑑 𐑧𐑝𐑼 𐑚𐑰 𐑦𐑯𐑳𐑓 𐑓𐑹 𐑿?"'],0,6],[3,3,['"It will only be enough when it is perfect, spotless, smooth-landing! You do not understand."','"Só será suficiente quando for exato, polido, perfeito! Tu não entenderias"','"𐑦𐑑 𐑢𐑦𐑤 𐑴𐑯𐑤𐑦 𐑚𐑰 𐑦𐑯𐑳𐑓 𐑢𐑧𐑯 𐑦𐑑 𐑦𐑟 𐑐𐑻𐑓𐑧𐑒𐑑, 𐑕𐑐𐑪𐑑𐑤𐑩𐑕, 𐑕𐑥𐑵𐑞-𐑤𐑨𐑯𐑛𐑦𐑙! 𐑿 𐑛𐑵 𐑯𐑪𐑑 𐑳𐑯𐑛𐑼𐑕𐑑𐑨𐑯𐑛."'],0,7],[3,4,['"I am trying my best, yet it is still unsufficient."','"Eu estou dando o meu melhor, e ainda assim não é suficiente."','"𐑲 𐑨𐑥 𐑑𐑮𐑲𐑦𐑙 𐑥𐑲 𐑚𐑧𐑕𐑑, 𐑘𐑧𐑑 𐑦𐑑 𐑦𐑟 𐑕𐑑𐑦𐑤 𐑳𐑯𐑕𐑩𐑓𐑦𐑖𐑩𐑯𐑑."'],0,8],[2,4,['"If you wan\'it to be perfect sooooo bad, add some soul to your songs, they sound mechanic."','"Se você quer elas tããããão perfeitas, podia dar um pouco de alma nelas, soam muito robóticas."','"𐑦𐑓 𐑿 𐑢𐑪𐑯𐑦𐑑 𐑑 𐑚𐑰 𐑐𐑻𐑓𐑧𐑒𐑑 𐑕𐑵𐑵𐑵𐑵𐑵 𐑚𐑨𐑛, 𐑨𐑛 𐑕𐑳𐑥 𐑕𐑴𐑤 𐑑 𐑿𐑼 𐑕𐑪𐑙𐑟, 𐑞𐑱 𐑕𐑬𐑯𐑛 𐑥𐑩𐑒𐑨𐑯𐑦𐑒."'],0,9],[2,3,['"Heck, even the outfit\'s dull, I look like a doll."','"Até o uniforme é chato, eu pareço uma boneca."','"𐑣𐑧𐑒, 𐑰𐑝𐑩𐑯 𐑞 𐑬𐑑𐑓𐑦𐑑𐑕 𐑛𐑵𐑤, 𐑲 𐑤𐑫𐑒 𐑤𐑲𐑒 𐑩 𐑛𐑪𐑤."'],0,10],[3,3,['"...What did you just say?"','"...O que foi que tu disse?"','"...𐑢𐑪𐑑 𐑛𐑦𐑛 𐑿 𐑡𐑳𐑕𐑑 𐑕𐑱?"'],0,11],[3,5,['"Do not dare criticizing the work of your mother like that, It is the reason you have food and shelter."','"Não se atreva a criticar o trabalho de sua mãe, é graças a ele que tu tens comida e abrigo."','"𐑛𐑵 𐑯𐑪𐑑 𐑛𐑺 𐑒𐑮𐑦𐑑𐑦𐑕𐑲𐑟𐑦𐑙 𐑞 𐑢𐑻𐑒 𐑝 𐑿𐑼 𐑥𐑳𐑞𐑼 𐑤𐑲𐑒 𐑞𐑨𐑑, 𐑦𐑑 𐑦𐑟 𐑞 𐑮𐑰𐑟𐑩𐑯 𐑿 𐑣𐑨𐑝 𐑓𐑵𐑛 𐑯 𐑖𐑧𐑤𐑑𐑼."'],0,12],[2,5,['"It iS tHe reAsON yOu hAvE FoOD aNd SheLtEr."','"É gRaçAs a eLe Que tu tENs coMiDa e aBriGo."','"𐑦𐑑 𐑦𐑟 𐑞 𐑮𐑰𐑟𐑩𐑯 𐑿 𐑣𐑨𐑝 𐑓𐑵𐑛 𐑯 𐑖𐑧𐑤𐑑𐑼."'],0,13],[2,3,['"You know very damn well most of the money comes from the merchandise."','"Você sabe muito bem que a maior parte do dinheiro vem das mercadorias."','"𐑿 𐑯𐑴 𐑝𐑧𐑮𐑦 𐑛𐑨𐑥 𐑢𐑧𐑤 𐑥𐑴𐑕𐑑 𐑝 𐑞 𐑥𐑳𐑯𐑦 𐑒𐑳𐑥𐑟 𐑓𐑮𐑪𐑥 𐑞 𐑥𐑻𐑗𐑩𐑯𐑛𐑲𐑟."'],0,14],[3,4,['"Money is money, sweetie, I am doing what I can to take care of you. If it is not good enough, then how would I spoil you?"','"Dinheiro é dinheiro, querida, eu estou fazendo o que posso pra cuidar de vocês. Se não é bom o suficiente, então como eu deveria mimá-los?"','"𐑥𐑳𐑯𐑦 𐑦𐑟 𐑥𐑳𐑯𐑦, 𐑕𐑢𐑰𐑑𐑦, 𐑲 𐑨𐑥 𐑛𐑵𐑦𐑙 𐑢𐑪𐑑 𐑲 𐑒𐑨𐑯 𐑑 𐑑𐑱𐑒 𐑒𐑺 𐑝 𐑿. 𐑦𐑓 𐑦𐑑 𐑦𐑟 𐑯𐑪𐑑 𐑜𐑫𐑛 𐑦𐑯𐑳𐑓, 𐑞𐑧𐑯 𐑣𐑬 𐑢𐑫𐑛 𐑲 𐑕𐑐𐑶𐑤 𐑿?"'],0,15],[3,3,['"You are the most precious child I have, and you know that. Do not make me hate you."','"Tu és a filha mais preciosa que eu tenho, e você sabe disso. Não me faça ter que te odiar."','"𐑿 𐑸 𐑞 𐑥𐑴𐑕𐑑 𐑐𐑮𐑧𐑖𐑩𐑕 𐑗𐑲𐑤𐑛 𐑲 𐑣𐑨𐑝, 𐑯 𐑿 𐑯𐑴 𐑞𐑨𐑑. 𐑛𐑵 𐑯𐑪𐑑 𐑥𐑱𐑒 𐑥𐑰 𐑣𐑱𐑑 𐑿."'],0,16],[2,3,['"Whatever Petal. One day you\'ll see why everyone else left you."','"E? Um dia você vai ver por que todo mundo te abandonou."','"𐑢𐑪𐑑𐑧𐑝𐑼 ·𐑐𐑧𐑑𐑩𐑤. 𐑢𐑳𐑯 𐑛𐑱 𐑿𐑤 𐑕𐑰 𐑢𐑲 𐑧𐑝𐑮𐑦𐑢𐑳𐑯 𐑧𐑤𐑕 𐑤𐑧𐑓𐑑 𐑿."'],0,17],[3,3,['"As if! I still have a good reputation, Winterblush. It is not going to happen anytime soon."','"Como se fosse acontecer!, Eu tenho uma otima reputação Winterblush. Isso não vai ocorrer tão cedo."','"𐑨𐑟 𐑦𐑓! 𐑲 𐑕𐑑𐑦𐑤 𐑣𐑨𐑝 𐑩 𐑜𐑫𐑛 𐑮𐑧𐑐𐑿𐑑𐑱𐑖𐑩𐑯, ·𐑢𐑦𐑯𐑑𐑼𐑚𐑤𐑳𐑖. 𐑦𐑑 𐑦𐑟 𐑯𐑪𐑑 𐑜𐑴𐑦𐑙 𐑑 𐑣𐑨𐑐𐑩𐑯 𐑧𐑯𐑦𐑑𐑲𐑥 𐑕𐑵𐑯."'],0,18],[2,4,['"...I can\'t wait to leave."','"...Mal posso esperar fugir daqui."','"...𐑲 𐑒𐑨𐑯𐑑 𐑢𐑱𐑑 𐑑 𐑤𐑰𐑝."'],0,0]],\
[[3],[5,1,['You wake up, tired. At least the dream you had this time was not as scary.','Você acorda, cansada. Pelo menos o sonho esta noite não foi tão assustador','𐑿 𐑢𐑱𐑒 𐑳𐑐, 𐑑𐑲𐑼𐑛. 𐑨𐑑 𐑤𐑰𐑕𐑑 𐑞 𐑛𐑮𐑰𐑥 𐑿 𐑣𐑨𐑛 𐑞𐑦𐑕 𐑑𐑲𐑥 𐑢𐑪𐑟 𐑯𐑪𐑑 𐑨𐑟 𐑕𐑒𐑺𐑦.'],0,2],[5,1,['You see Winterblush beside you, who couldn\'t have any sleep','Você vê Winterblush do seu lado, que não conseguiu dormir','𐑿 𐑕𐑰 ·𐑢𐑦𐑯𐑑𐑼𐑚𐑤𐑳𐑖 𐑚𐑦𐑕𐑲𐑛 𐑿 𐑣𐑵 𐑒𐑫𐑛𐑯𐑑 𐑣𐑨𐑝 𐑧𐑯𐑦 𐑕𐑤𐑰𐑐'],0,3],[2,3,['"You better have a nice sleep”','"Pelo menos você dormiu bem né?"','"𐑿 𐑚𐑧𐑑𐑼 𐑣𐑨𐑝 𐑩 𐑯𐑲𐑕 𐑕𐑤𐑰𐑐"'],0,4],[0,2,['"Huh?"','"Que?"','𐑣𐑳?'],0,5],[2,1,['"I had to deal with Petal and her shows. I was one of those singers."','"Eu tive que lidar com a Petal e os shows dela. Fui uma das cantoras."','"𐑲 𐑣𐑨𐑛 𐑑 𐑛𐑰𐑤 𐑢𐑦𐑞 ·𐑐𐑧𐑑𐑩𐑤 𐑯 𐑣𐑻 𐑖𐑴𐑟. 𐑲 𐑢𐑪𐑟 𐑢𐑳𐑯 𐑝 𐑞𐑴𐑟 𐑕𐑦𐑙𐑻𐑟"'],0,6],[2,4,['"I hate my voice and I couldn\'t get the lyrics out so Petal panicked and after the show she ignored me and just came home"','"Como eu odeio minha voz, no ultimo show eu não consegui cantar e a Petal surtou, depois me ignorou, e ainda veio brava pra casa."','"𐑲 𐑣𐑱𐑑 𐑥𐑲 𐑝𐑶𐑕 𐑯 𐑲 𐑒𐑫𐑛𐑯𐑑 𐑜𐑧𐑑 𐑞 𐑤𐑦𐑮𐑦𐑒𐑕 𐑬𐑑 𐑕𐑴 ·𐑐𐑧𐑑𐑩𐑤 𐑐𐑨𐑯𐑦𐑒𐑑 𐑯 𐑨𐑓𐑑𐑼 𐑞 𐑖𐑴 𐑖𐑰 𐑦𐑜𐑯𐑹𐑛 𐑥𐑰 𐑯 𐑡𐑳𐑕𐑑 𐑒𐑱𐑥 𐑣𐑴𐑥"'],0,7],[0,5,['"..."','"..."','"..."'],0,8],[2,5,['"Look...If you\'re not careful with her, who knows what happens?"','"Olha... Se você não for cuidadosa com ela, quem sabe o que aconteceria?"','"𐑤𐑫𐑒...𐑦𐑓 𐑿𐑼 𐑯𐑪𐑑 𐑒𐑺𐑓𐑩𐑤 𐑢𐑦𐑞 𐑣𐑻 𐑣𐑵 𐑯𐑴𐑟 𐑢𐑪𐑑 𐑣𐑨𐑐𐑩𐑯𐑟"'],0,9],[5,0,'',2,['Yeah','É','𐑘𐑧'],10,['What?','Que?','𐑢𐑪𐑑?'],13],[0,5,['"Yeah..."','"É..."','"𐑘𐑧..."'],0,11],[2,5,['"You better get our mail soon, or else..."','"É melhor ir buscar o correio, Lavvy"','"𐑿 𐑚𐑧𐑑𐑼 𐑜𐑧𐑑 𐑬𐑼 𐑥𐑱𐑤 𐑕𐑵𐑯 𐑹 𐑧𐑤𐑕 ·𐑤𐑨𐑝𐑦"'],0,12],[0,5,['"Okay..."','"Tá..."','"𐑴𐑒𐑱..."'],0,999],[0,6,['"What does happen?"','"O que acontece?"','"𐑢𐑪𐑑 𐑛𐑳𐑟 𐑣𐑨𐑐𐑩𐑯"'],0,14],[2,4,['"Heh. I\'m sure you\'ll know exactly what happens."','"Certeza que logo saberá exatamente o que acontece."','"𐑣𐑧. 𐑲𐑥 𐑖𐑫𐑼 𐑿𐑤 𐑯𐑴 𐑦𐑜𐑟𐑨𐑒𐑑𐑤𐑦 𐑢𐑪𐑑 𐑣𐑨𐑐𐑩𐑯𐑟"'],0,15],[2,6,['"..."','"..."','"..."'],0,16],[0,2,['"You should get our mail soon Lavvy"','"Você deveria ir logo pegar o correio Lavvy."','"𐑿 𐑖𐑫𐑛 𐑜𐑧𐑑 𐑬𐑼 𐑥𐑱𐑤 𐑕𐑵𐑯 ·𐑤𐑨𐑝𐑦"'],0,999]]
]
#charactres : 0-lav 1-soap 2-WB 3- Petal 4-lav eep 5-narrator
#icons: 0-happy 1- sad 2- idk

func load_story(num):
	storystep = num
	match num:
		0:
			match level:
				1:
					Soap = [false,[0,0],[]]
					Wb = [false,[0,0],[]]
					Petal = [false,[0,0],[]]
				2:
					Soap = [false,[0,0],[]]
					Wb = [false,[0,0],[]]
					Petal = [false,[0,0],[]]
				3:
					Soap = [false,[0,0],[]]
					Wb = [false,[0,0],[]]
					Petal = [true,[9,17,3],[]]

		1:
			match level:
				1:
					Soap = [false,[0,0],[]]
					Wb = [false,[0,0],[]]
					Petal = [false,[0,0],[]]
				2:
					Soap = [false,[0,0],[]]
					Wb = [false,[0,0],[]]
					Petal = [false,[0,0],[]]
				3:
					Soap = [false,[0,0],[]]
					Wb = [false,[0,0],[]]
					Petal = [false,[0,0],[]]


func get_matrix(a,b,mat):
	if a <= cols and b <= rows and a >= 0 and b >= 0:
		return mat[a][b]
	else:
		return 999


func prepare(n):
	loading = true
	fgoals = 0
	goals = 0
	fill_rect(room_matrix,0,0,cols,rows,999)
	fill_rect(special_matrix,0,0,cols,rows,0)
	fill_rect(hurt_matrix,0,0,cols,rows,0)
	match n:
		1:
			cols = 17
			rows = 14
		2:
			cols = 17
			rows = 14
	await get_tree().create_timer(3).timeout
	loading = false

func _ready():
	for a in range(64):
		var c := []
		var r:=[]
		var k:=[]
		for b in range(64):
			c.append(0)
			k.append(0)
			r.append(999)
		room_matrix.append(r)
		special_matrix.append(c)
		hurt_matrix.append(k)
		

func update_text_matrix():
	storystep += 1

func fill_rect(m, a, b, c, d, v):
	for f in range(a, c + 1):
		for g in range(b, d + 1):
			m[f][g] = v

func _process(_delta: float) -> void:
	mini_delay = (0.15 * m1 * m2 * m3)
	if hunger < 20:
		m1 = 1.3
	else:
		m1= 1
	if water < 20:
		m2 = 1.3
	else:
		m2 = 1
	if sleep < 20:
		m3 = 1.3
	else:
		m3 = 1
	pass
