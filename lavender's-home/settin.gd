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
		$Stats.text = str_to_var(FileAccess.open(Global.lan[Global.lang],FileAccess.READ).get_as_text().replace("\t", ""))["stats"]
		$r.text = str_to_var(FileAccess.open(Global.lan[Global.lang],FileAccess.READ).get_as_text().replace("\t", ""))["retry"]
		$quit.text = str_to_var(FileAccess.open(Global.lan[Global.lang],FileAccess.READ).get_as_text().replace("\t", ""))["quit"]
		$Allstats.text = str_to_var(FileAccess.open(Global.lan[Global.lang],FileAccess.READ).get_as_text().replace("\t", ""))["healthy"]+str(Global.health)+"\n"+str_to_var(FileAccess.open(Global.lan[Global.lang],FileAccess.READ).get_as_text().replace("\t", ""))["hunger"]+str(Global.hunger)+"\n"+str_to_var(FileAccess.open(Global.lan[Global.lang],FileAccess.READ).get_as_text().replace("\t", ""))["water"]+str(Global.water)+"\n"+str_to_var(FileAccess.open(Global.lan[Global.lang],FileAccess.READ).get_as_text().replace("\t", ""))["sleep"]+str(Global.sleep)
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
