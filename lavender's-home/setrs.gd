extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$lan._select_int(Global.lang)
	$gos.value = Global.GridT
	$vol.value = Audio.volume_linear
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.lang = $lan.get_selected_id()
	if $lan.item_selected:
		$Settings.text = str_to_var(FileAccess.open(Global.lan[Global.lang],FileAccess.READ).get_as_text().replace("\t", ""))["settings"]
		$"Grid Opacity".text = str_to_var(FileAccess.open(Global.lan[Global.lang],FileAccess.READ).get_as_text().replace("\t", ""))["grid"]
		$Volume.text = str_to_var(FileAccess.open(Global.lan[Global.lang],FileAccess.READ).get_as_text().replace("\t", ""))["volume"]
		$Language.text = str_to_var(FileAccess.open(Global.lan[Global.lang],FileAccess.READ).get_as_text().replace("\t", ""))["language"]
		$back.text = str_to_var(FileAccess.open(Global.lan[Global.lang],FileAccess.READ).get_as_text().replace("\t", ""))["back"]
	if $back.button_pressed:
		Global.toggle = false
	Global.GridT = $gos.value
	Audio.volume_linear = $vol.value
	if Global.toggle:
		visible = true
	else:
		visible = false
