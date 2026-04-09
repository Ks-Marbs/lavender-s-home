extends Node2D

func _ready() -> void:
	Global.level = int(get_tree().current_scene.scene_file_path)
	Global.prepare(Global.level)
	$Soap.visible = Global.Soap[0];$Soap.position = Vector2(Global.Soap[2*Global.level-1],Global.Soap[2*Global.level])*36;$Soap.t1=Global.Soap[7]
	$Petal.visible = Global.Petal[0];$Petal.position = Vector2(Global.Petal[2*Global.level-1],Global.Petal[2*Global.level])*36;$Petal.t1=Global.Petal[7]
	$Winterblush.visible = Global.Winterblush[0];$Winterblush.position = Vector2(Global.Winterblush[2*Global.level-1],Global.Winterblush[2*Global.level])*36;$Winterblush.t1=Global.Winterblush[7] #aaaaaaaaaaaaaaa
	if Global.took_stairs:
		match Global.level:
			1:
				$Lav.position = Vector2(540,0)
				$Lav.t1 = 2
			2:
				$Lav.position = Vector2(576,180)
				$Lav.t1 = 1
		await get_tree().create_timer(1.5).timeout
		Global.took_stairs = false
	elif Global.took_door:
		match Global.level:
			3:
				$Lav.position = Vector2(23,24)*36
				$Lav.t1 = 1
			2:
				$Lav.position = Vector2(15,14)*36
				$Lav.t1 = 0
	Global.moves = 0
	for cell in $ice.get_used_cells():
		Global.special_matrix[cell.x][cell.y] = 1
	for cell in $stuff.get_used_cells_by_id(-1,Vector2i(3,6)):
			Global.room_matrix[cell.x][cell.y] = 999
	for i in range(5):
		for cell in $stuff.get_used_cells_by_id(-1,Vector2i(i,7)):
				Global.room_matrix[cell.x][cell.y] = i
		for c in $hurt.get_used_cells_by_id(-1,Vector2i(i,7)):
				Global.hurt_matrix[c.x][c.y] = i*5

func _process(delta: float) -> void:
	$grid.self_modulate = Color(1.0, 1.0, 1.0, Global.GridT)
	if Input.is_action_just_released("esc") and not Global.clear:
		if Global.toggle:
			Global.toggle = false
		else:
			Global.toggle = true
	if Global.fgoals == Global.goals and Global.fgoals != 0 and  Global.goals != 0:
		Global.clear = true

	if Global.storystep == 2 and Global.black:
		$Winterblush.position = Vector2(9,14)*36
		$Soap.position = Vector2(60,60)*36
		$Lav.position = Vector2(8,14)*36
		$Lav.t1 = 3
		$Lav/Camera2D/TextBox.visible = false
		$Lav/Sprite2d.visible = false
		$Winterblush.interaction = 0
		$Winterblush.visible = 0
		$Winterblush/Sprite2d.visible = 0
		await get_tree().create_timer(4).timeout
		Global.black = 0.5
