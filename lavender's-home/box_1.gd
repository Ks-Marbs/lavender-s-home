extends Area2D
#Box
var del=0
var yes = true
var isplayer := false
var isbox := true
var isgoal := false
var can_move := false
var tile_size := 36
var step_size := 4.5
var last_move := Vector2.ONE
var nextplan_move := Vector2.ONE
var moving := false
var xcell := (position.x - (int(position.x) % 36)) / 36
var ycell := (position.y - (int(position.y) % 36)) / 36
var one = preload("res://images/box.1.png")
var two = preload("res://images/box.2.png")
var three = preload("res://images/box.3.png")
func may_slide(dir):
	if Global.get_matrix(xcell, ycell, Global.room_matrix) == 0:
		if (dir == Vector2.RIGHT and ($RightRay.is_colliding() or Global.get_matrix(xcell+1, ycell, Global.room_matrix)==999))\
		or (dir == Vector2.LEFT and ($LeftRay.is_colliding() or Global.get_matrix(xcell-1, ycell, Global.room_matrix)==999))\
		or (dir == Vector2.DOWN and ($DownRay.is_colliding() or Global.get_matrix(xcell, ycell+1, Global.room_matrix)==999))\
		or (dir == Vector2.UP and ($UpRay.is_colliding() or Global.get_matrix(xcell, ycell-1, Global.room_matrix)==999)):
			can_move = false
		else:
			can_move = true
	else:
		if (dir == Vector2.RIGHT and ($RightRay.is_colliding() or Global.get_matrix(xcell+1, ycell, Global.room_matrix)!=Global.get_matrix(xcell, ycell, Global.room_matrix)) and Global.get_matrix(xcell+1, ycell, Global.room_matrix) != 0)\
		or (dir == Vector2.LEFT and ($LeftRay.is_colliding() or Global.get_matrix(xcell-1, ycell, Global.room_matrix)!=Global.get_matrix(xcell, ycell, Global.room_matrix)) and Global.get_matrix(xcell-1, ycell, Global.room_matrix) != 0)\
		or (dir == Vector2.DOWN and ($DownRay.is_colliding() or Global.get_matrix(xcell, ycell+1, Global.room_matrix)!=Global.get_matrix(xcell, ycell, Global.room_matrix)) and Global.get_matrix(xcell, ycell+1, Global.room_matrix) != 0)\
		or (dir == Vector2.UP and ($UpRay.is_colliding() or Global.get_matrix(xcell, ycell-1, Global.room_matrix)!=Global.get_matrix(xcell, ycell, Global.room_matrix)) and Global.get_matrix(xcell, ycell-1, Global.room_matrix) != 0):
			can_move = false
		else:
			can_move = true
	return can_move

func push():
		if Global.get_matrix(xcell, ycell, Global.room_matrix) == 0:
			if $LeftRay.is_colliding() and $LeftRay.get_collider().isplayer:
				if $LeftRay.get_collider().nextplan_move == Vector2.RIGHT and $LeftRay.get_collider().can_move == true:
					if $RightRay.is_colliding() and !$RightRay.get_collider().isgoal:
						can_move=false
					else:
						nextplan_move = Vector2.RIGHT
						await get_tree().create_timer(del).timeout
						move_step(nextplan_move)

			elif $RightRay.is_colliding() and $RightRay.get_collider().isplayer:
				if $RightRay.get_collider().nextplan_move == Vector2.LEFT and $RightRay.get_collider().can_move == true:
					if $LeftRay.is_colliding() and !$LeftRay.get_collider().isgoal:
						can_move=false
					else:
						nextplan_move = Vector2.LEFT
						await get_tree().create_timer(del).timeout
						move_step(nextplan_move)

			elif $DownRay.is_colliding() and $DownRay.get_collider().isplayer:
				if $DownRay.get_collider().nextplan_move == Vector2.UP and $DownRay.get_collider().can_move == true:
					if $UpRay.is_colliding() and !$UpRay.get_collider().isgoal:
						can_move=false
					else:
						nextplan_move = Vector2.UP
						await get_tree().create_timer(del).timeout
						move_step(nextplan_move)

			elif $UpRay.is_colliding() and $UpRay.get_collider().isplayer:
				if $UpRay.get_collider().nextplan_move == Vector2.DOWN and $UpRay.get_collider().can_move == true:
					if $DownRay.is_colliding() and !$DownRay.get_collider().isgoal:
						can_move=false
					else:
						nextplan_move = Vector2.DOWN
						await get_tree().create_timer(del).timeout
						move_step(nextplan_move)

		else:
			if $LeftRay.is_colliding() and $LeftRay.get_collider().isplayer:
				if $LeftRay.get_collider().nextplan_move == Vector2.RIGHT and $LeftRay.get_collider().can_move == true:
					if $RightRay.is_colliding() and !$RightRay.get_collider().isgoal:
						can_move=false
					else:
						can_move = true
						nextplan_move = Vector2.RIGHT
						if Global.get_matrix(xcell, ycell, Global.room_matrix) == Global.get_matrix(xcell + 1, ycell, Global.room_matrix) \
						or Global.get_matrix(xcell + 1, ycell, Global.room_matrix) == 0:
							await get_tree().create_timer(del).timeout
							move_step(nextplan_move)
						else:
							can_move = false

			elif $RightRay.is_colliding() and $RightRay.get_collider().isplayer:
				if $RightRay.get_collider().nextplan_move == Vector2.LEFT and $RightRay.get_collider().can_move == true:
					if $LeftRay.is_colliding() and !$LeftRay.get_collider().isgoal:
						can_move=false
					else:
						can_move = true
						nextplan_move = Vector2.LEFT
						if Global.get_matrix(xcell, ycell, Global.room_matrix) == Global.get_matrix(xcell - 1, ycell, Global.room_matrix) \
						or Global.get_matrix(xcell - 1, ycell, Global.room_matrix) == 0:
							await get_tree().create_timer(del).timeout
							move_step(nextplan_move)
						else:
							can_move = false

			elif $DownRay.is_colliding() and $DownRay.get_collider().isplayer:
				if $DownRay.get_collider().nextplan_move == Vector2.UP and $DownRay.get_collider().can_move == true:
					if $UpRay.is_colliding() and !$UpRay.get_collider().isgoal:
						can_move=false
					else:
						can_move = true
						nextplan_move = Vector2.UP
						if Global.get_matrix(xcell, ycell, Global.room_matrix) == Global.get_matrix(xcell, ycell - 1, Global.room_matrix) \
						or Global.get_matrix(xcell, ycell - 1, Global.room_matrix) == 0:
							await get_tree().create_timer(del).timeout
							move_step(nextplan_move)
						else:
							can_move = false

			elif $UpRay.is_colliding() and $UpRay.get_collider().isplayer:
				if $UpRay.get_collider().nextplan_move == Vector2.DOWN and $UpRay.get_collider().can_move == true:
					if $DownRay.is_colliding() and !$DownRay.get_collider().isgoal:
						can_move=false
					else:
						can_move = true
						nextplan_move = Vector2.DOWN
						if Global.get_matrix(xcell, ycell, Global.room_matrix) == Global.get_matrix(xcell, ycell + 1, Global.room_matrix) \
						or Global.get_matrix(xcell, ycell + 1, Global.room_matrix) == 0:
							can_move = true
							await get_tree().create_timer(del).timeout
							move_step(nextplan_move)
						else:
							can_move = false
		 
func wiggle():
	while yes:
		$Sprite2d.texture = one
		await get_tree().create_timer(Global.wiggle_delay).timeout
		$Sprite2d.texture = two
		await get_tree().create_timer(Global.wiggle_delay).timeout
		$Sprite2d.texture = three
		await get_tree().create_timer(Global.wiggle_delay).timeout
		$Sprite2d.texture = two
		await get_tree().create_timer(Global.wiggle_delay).timeout

func _ready():
	wiggle()

func _process(delta):
	del = delta
	xcell = (position.x - (int(position.x) % 36)) / 36
	ycell = (position.y - (int(position.y) % 36)) / 36
	
	if $DownRay.is_colliding() and $DownRay.get_collider().isgoal:
		$DownRay.add_exception($DownRay.get_collider())
	elif $UpRay.is_colliding() and $UpRay.get_collider().isgoal:
		$UpRay.add_exception($UpRay.get_collider())
	elif $LeftRay.is_colliding() and $LeftRay.get_collider().isgoal:
		$LeftRay.add_exception($LeftRay.get_collider())
	elif $RightRay.is_colliding() and $RightRay.get_collider().isgoal:
		$RightRay.add_exception($RightRay.get_collider())


	if moving and not(int(position.x) % tile_size == 0 and int(position.y) % tile_size == 0):
		return

	elif Global.get_matrix(xcell,ycell,Global.special_matrix) == 2:
		await get_tree().create_timer(Global.mini_delay).timeout
		if may_slide(Vector2.UP) == true:
			nextplan_move=Vector2.UP
			move_step(Vector2.UP)
		else:
			push()

	elif Global.get_matrix(xcell,ycell,Global.special_matrix) == 3:
		await get_tree().create_timer(Global.mini_delay).timeout
		if  may_slide(Vector2.DOWN) == true:
			nextplan_move=Vector2.DOWN
			move_step(Vector2.DOWN)
		else:
			push()

	elif Global.get_matrix(xcell,ycell,Global.special_matrix) == 4:
		await get_tree().create_timer(Global.mini_delay).timeout
		if may_slide(Vector2.LEFT) == true:
			nextplan_move=Vector2.LEFT
			move_step(Vector2.LEFT)
		else:
			push()

	elif Global.get_matrix(xcell,ycell,Global.special_matrix) == 5:
		await get_tree().create_timer(Global.mini_delay).timeout
		if  may_slide(Vector2.RIGHT) == true:
			nextplan_move=Vector2.RIGHT
			move_step(Vector2.RIGHT)
		else:
			push()

	elif Global.get_matrix(xcell, ycell, Global.special_matrix) == 0 or Global.get_matrix(xcell, ycell, Global.special_matrix) == 1:
		push()

func move_step(dir: Vector2) -> void:
	if not moving:
		moving = true
		position += dir * step_size
		await get_tree().create_timer(Global.mini_delay).timeout

		while int(position.x) % tile_size != 0 or int(position.y) % tile_size != 0:
			position += dir * step_size
			await get_tree().create_timer(Global.mini_delay).timeout
		last_move = dir
		xcell = (position.x - (int(position.x) % 36)) / 36
		ycell = (position.y - (int(position.y) % 36)) / 36
		moving = false
