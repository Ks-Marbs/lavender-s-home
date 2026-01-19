extends Node2D

func _ready() -> void:
	Global.level = int(get_tree().current_scene.scene_file_path)
	Global.prepare(Global.level)
	if Global.took_stairs:
		match Global.level:
			1:
				$Lav.position = Vector2(540,0)
				$Lav.t1 = 2
			2:
				$Lav.position = Vector2(576,180)
				$Lav.t1 = 1
		await get_tree().create_timer(3).timeout
		Global.took_stairs = false
	Global.moves = 0
	for cell in $ice.get_used_cells():
		Global.special_matrix[cell.x][cell.y] = 1
	for cell in $stuff.get_used_cells():
		Global.room_matrix[cell.x][cell.y] = 999

func _process(delta: float) -> void:
	$grid.self_modulate = Color(1.0, 1.0, 1.0, Global.GridT)
	if Input.is_action_just_released("esc") and not Global.clear:
		if Global.toggle:
			Global.toggle = false
		else:
			Global.toggle = true
	if Global.fgoals == Global.goals and Global.fgoals != 0 and  Global.goals != 0:
		Global.clear = true
