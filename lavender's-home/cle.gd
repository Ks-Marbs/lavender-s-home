extends Node2D
var one = preload("res://images/star1.png")
var two = preload("res://images/star2.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$moves.text = ("Moves:" + str(Global.moves))
	if $back.button_pressed:
		Global.clear = false
		Global.level += 1
		get_tree().change_scene_to_file("res://level_"+str(Global.level)+".tscn")
	if $quit.button_pressed:
		Global.clear = false
		
		get_tree().change_scene_to_file("res://Start.tscn")
	if Global.clear:
		if Global.level != 15:
			Global.save[Global.level+1][4] = 1
		visible = true
	else:
		visible = false
	if Global.moves <= Global.save[Global.level][1]:
		$star1.texture = two
	else:
		$star1.texture = one
	if Global.moves <= Global.save[Global.level][2]:
		$star2.texture = two
	else:
		$star2.texture = one
	if Global.moves <= Global.save[Global.level][3]:
		$star3.texture = two
	else:
		$star3.texture = one
