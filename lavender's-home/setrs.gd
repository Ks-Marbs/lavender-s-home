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
		$"Grid Opacity".text = (["Grid Opacity","Opacidade da Grade","𐑜𐑮𐑦𐑛 𐑴𐑐𐑨𐑕𐑦𐑑𐑦"])[Global.lang]
		$Volume.text = (["Volume","Volume","𐑝𐑪𐑤𐑿𐑥"])[Global.lang]
		$Language.text = (["Language","Língua","𐑤𐑨𐑙𐑜𐑢𐑦𐑡"])[Global.lang]
		$back.text = (["Back","Voltar","𐑚𐑨𐑒"])[Global.lang]
	if $back.button_pressed:
		Global.toggle = false
	Global.GridT = $gos.value
	Audio.volume_linear = $vol.value
	if Global.toggle:
		visible = true
	else:
		visible = false
