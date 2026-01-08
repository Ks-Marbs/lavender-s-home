extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$gos.value = Global.GridT
	$vol.value = Audio.volume_linear
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
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
