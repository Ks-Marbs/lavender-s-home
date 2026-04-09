extends Area2D
var wiggling = false
var nextplan_move = Vector2.ZERO
var can_move := false
var isplayer := false
var yes=true
var on=false
var isgoal=false
var time= 1
var t1 = 0
var t2 = 0
var vis = 0.01
var del := 0.0
var active = false
var last_move := Vector2.ONE
var interaction:= 0
var item= 0
var xcell := (position.x - (int(position.x) % 36)) / 36
var ycell := (position.y - (int(position.y) % 36)) / 36
var numb = 0
var moving:= false
var tile_size := 36
var step_size := 4
func wiggle():
	if not wiggling:
		wiggling = true
		while int(position.x) % 36 == 0 and int(position.y) % 36 == 0:
			match nextplan_move:
				Vector2.UP:
					t1=0
				Vector2.DOWN:
					t1=1
				Vector2.LEFT:
					t1=2
				Vector2.RIGHT:
					t1=3
			t2+=1
			if t2==4:
				t2=0
			$Sprite2d.region_rect=Rect2(t1*72,t2*36,36,36)
			await get_tree().create_timer(Global.mini_delay*1.5).timeout
		wiggling = false

func showtex():
	vis += 0.2

func control():
	if not Global.toggle and not Global.clear and not Global.talking and numb > 0:
		match Global[self.name][numb+6]:
			0:
				nextplan_move = Vector2.ZERO
			1:
				nextplan_move = Vector2.LEFT
			2:
				nextplan_move = Vector2.RIGHT
			3:
				nextplan_move = Vector2.UP
			4:
				nextplan_move = Vector2.DOWN
		if nextplan_move != Vector2.ZERO: 
			if Global.get_matrix(xcell, ycell, Global.room_matrix) == 0:
				if Global.get_matrix(xcell+nextplan_move[0], ycell+nextplan_move[1], Global.room_matrix) != 999:
					can_move = true
					if not ((nextplan_move == Vector2.RIGHT and $RightRay.is_colliding()) or (nextplan_move == Vector2.LEFT and $LeftRay.is_colliding()) or (nextplan_move == Vector2.UP and $UpRay.is_colliding()) or (nextplan_move == Vector2.DOWN and $DownRay.is_colliding())):
						move_step(nextplan_move)
					else: can_move = false
			elif Global.get_matrix(xcell+nextplan_move[0], ycell+nextplan_move[1], Global.room_matrix)==Global.get_matrix(xcell, ycell, Global.room_matrix) or Global.get_matrix(xcell+nextplan_move[0], ycell+nextplan_move[1], Global.room_matrix)==0  : 
				can_move = true
				move_step(nextplan_move)
			else: can_move = false
		else: can_move = false

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

func _ready():
	wiggle()
	move_step(Vector2.ZERO)

func _process(delta):
	del = delta
	$RichTextLabel.visible_characters = vis
	if(($LeftRay.is_colliding() and $LeftRay.get_collider().isplayer and $LeftRay.get_collider().t1==3) or\
	 ($RightRay.is_colliding() and $RightRay.get_collider().isplayer and $RightRay.get_collider().t1==2) or\
	($UpRay.is_colliding() and $UpRay.get_collider().isplayer and $UpRay.get_collider().t1==1) or\
	($DownRay.is_colliding() and $DownRay.get_collider().isplayer and $DownRay.get_collider().t1==0)) and Global.get_matrix(xcell,ycell,Global.room_matrix)==0 or\
	(($LeftRay.is_colliding() and $LeftRay.get_collider().isplayer and$LeftRay.get_collider().t1==3) and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell-1,ycell,Global.room_matrix)) or Global.get_matrix(xcell-1,ycell,Global.room_matrix) == 0)) or\
	 (($RightRay.is_colliding() and $RightRay.get_collider().isplayer and$RightRay.get_collider().t1==2) and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell+1,ycell,Global.room_matrix)) or Global.get_matrix(xcell+1,ycell,Global.room_matrix) == 0)) or\
	(($UpRay.is_colliding() and $UpRay.get_collider().isplayer and$UpRay.get_collider().t1==1)  and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell,ycell-1,Global.room_matrix)) or Global.get_matrix(xcell,ycell-1,Global.room_matrix) == 0)) or\
	(($DownRay.is_colliding() and $DownRay.get_collider().isplayer and$DownRay.get_collider().t1==0) and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell,ycell+1,Global.room_matrix)) or Global.get_matrix(xcell,ycell+1,Global.room_matrix) == 0)):
		showtex()
		$RichTextLabel.text = (str(self.name))
		if Input.is_action_pressed("in") and on:
			on = false
			if interaction == 0: 
				interaction = 1
				return
		else:
			on = true
	else:
		vis = 0

	if moving or not (int(position.x) % tile_size == 0 and int(position.y) % tile_size == 0):
		can_move = false
		return
	elif not wiggling:
		wiggle()

	match Global.get_matrix(xcell,ycell,Global.special_matrix):
		1:
			if may_slide(nextplan_move) == true and nextplan_move != Vector2.ZERO:
				ice_step(nextplan_move)
			else:
				control()

		2:
			if may_slide(Vector2.UP) == true:
				ice_step(Vector2.UP)
				nextplan_move=Vector2.UP
			else:
				control()

		3:
			if  may_slide(Vector2.DOWN) == true:
				ice_step(Vector2.DOWN)
				nextplan_move=Vector2.DOWN
			else:
				control()

		4:
			if may_slide(Vector2.LEFT) == true:
				ice_step(Vector2.LEFT)
				nextplan_move=Vector2.LEFT
			else:
				control()

		5:
			if  may_slide(Vector2.RIGHT) == true:
				ice_step(Vector2.RIGHT)
				nextplan_move=Vector2.RIGHT
			else:
				control()

		0:
			control()

	if (interaction == 13 and Global.storystep == 0):
		get_tree().change_scene_to_file("res://level_1.tscn")
		Global.storystep+=1
	if str(self.name) == "Soap" and interaction == 29 and Global.storystep == 1:
		Global.black = true
		await get_tree().create_timer(4).timeout
		interaction = 0
		Global.storystep = 2
		Global.sleeping = true
		visible = 0
	if str(self.name) == "Winterblush" and interaction == 19 and Global.storystep == 2:
		Global.black = true
		await get_tree().create_timer(4).timeout
		Global.storystep = 3
		$Sprite2d.visible = 1
		visible = 1
		Global.sleeping = false
		Global.black = false

func move_step(dir: Vector2) -> void:
	if dir != Vector2.ZERO:
		match dir:
			Vector2.UP:
				t1=0
			Vector2.DOWN:
				t1=1
			Vector2.LEFT:
				t1=2
			Vector2.RIGHT:
				t1=3
		moving = true
		position += dir * step_size
		await get_tree().create_timer(Global.mini_delay).timeout
		while int(position.x) % tile_size != 0 or int(position.y) % tile_size != 0:
			t2+=1
			if t2==4:
				t2=0
			$Sprite2d.region_rect=Rect2(t1*72+36,t2*36,36,36)
			position += dir * step_size
			await get_tree().create_timer(Global.mini_delay).timeout
		last_move = dir
		xcell = (position.x - (int(position.x) % 36)) / 36
		ycell = (position.y - (int(position.y) % 36)) / 36
		Global.x = xcell
		Global.y = ycell
		moving = false
		numb += 1

func ice_step(dir: Vector2) -> void:
	match dir:
		Vector2.UP:
			t1=0
		Vector2.DOWN:
			t1=1
		Vector2.LEFT:
			t1=2
		Vector2.RIGHT:
			t1=3
	if not (Global.toggle or Global.clear):
		moving = true
		position += dir * step_size
		await get_tree().create_timer(Global.mini_delay).timeout
		while int(position.x) % tile_size != 0 or int(position.y) % tile_size != 0:
			t2+=1
			if t2==4:
				t2=0
			$Sprite2d.region_rect=Rect2(t1*72,t2*36,36,36)
			position += dir * step_size
			await get_tree().create_timer( Global.mini_delay*1.5).timeout
		last_move = dir
		xcell = (position.x - (int(position.x) % 36)) / 36
		ycell = (position.y - (int(position.y) % 36)) / 36
		Global.x = xcell
		Global.y = ycell
		moving = false
