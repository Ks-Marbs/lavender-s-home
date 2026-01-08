extends Node2D

func _ready() -> void:
	Global.prepare(Global.level)
	if Global.level != 15:
		$num.text = str(Global.level)
	else:
		$Lav/Camera2D/num.text = "15"
	Global.moves = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$grid.self_modulate = Color(1.0, 1.0, 1.0, Global.GridT)
	if Input.is_action_just_released("esc") and not Global.clear:
		if Global.toggle:
			Global.toggle = false
		else:
			Global.toggle = true
	if Global.fgoals == Global.goals and Global.fgoals != 0 and  Global.goals != 0:
		Global.clear = true
