extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$lan._select_int(0)
	$gos.value = Global.GridT
	$vol.value = Audio.volume_linear
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.lang = $lan.get_selected_id()
	if $lan.item_selected:
		$Settings.text = (["Settings","Configurações","𐑕𐑧𐑑𐑦𐑙𐑟"])[Global.lang]
		$Stats.text = (["Stats","Status","𐑕𐑑𐑨𐑑𐑕"])[Global.lang]
		$"Grid Opacity".text = (["Grid Opacity","Opacidade da Grade","𐑜𐑮𐑦𐑛 𐑴𐑐𐑨𐑕𐑦𐑑𐑦"])[Global.lang]
		$Volume.text = (["Volume","Volume","𐑝𐑪𐑤𐑿𐑥"])[Global.lang]
		$Language.text = (["Language","Língua","𐑤𐑨𐑙𐑜𐑢𐑦𐑡"])[Global.lang]
		$r.text = (["Retry","Reiniciar","𐑮𐑰𐑑𐑮𐑲"])[Global.lang]
		$quit.text = (["Quit","Quitar","𐑒𐑢𐑦𐑑"])[Global.lang]
		$back.text = (["Back","Voltar","𐑚𐑨𐑒"])[Global.lang]
	$Allstats.text = (["Health:","Saúde:","𐑣𐑧𐑤𐑔:"])[Global.lang]+str(Global.health)+(["\n Hunger:","\n Fome:","\n 𐑣𐑳𐑙𐑜𐑼:"])[Global.lang]+str(Global.hunger)+(["\n Hydration:","\n Hidratação:","\n 𐑣𐑲𐑛𐑮𐑱𐑖𐑩𐑯:"])[Global.lang]+str(Global.water)+(["\n Sleepness:","\n Sono:","\n 𐑕𐑤𐑰𐑐𐑯𐑧𐑕:"])[Global.lang]+str(Global.sleep)
	if $back.button_pressed:
		Global.toggle = false
	if $r.button_pressed:
		Global.toggle = false
		get_tree().change_scene_to_file("res://level_"+str(Global.level)+".tscn")
	if $quit.button_pressed:
		Global.toggle = false
		get_tree().change_scene_to_file("res://Start.tscn")
	Global.GridT = $gos.value
	Audio.volume_linear = $vol.value
	if Global.toggle:
		visible = true
	else:
		visible = false
