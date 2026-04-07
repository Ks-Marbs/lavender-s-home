extends Area2D
var isbox := false
var on := false
var hurten := false
var del = 0.18
var yes = true
var isplayer := true
var isgoal := false
var tile_size := 36
var step_size := 4
var last_move := Vector2.ONE
var nextplan_move := Vector2.ONE
var moving := false
var can_move := false
var xcell := (position.x - (int(position.x) % 36)) / 36
var ycell := (position.y - (int(position.y) % 36)) / 36
var t1:=0 # direction
var t2:= 0 #frame
var wiggling := false

func e(ray):
	if typeof(Global.story[Global.storystep][ray.get_collider().interaction][2]) == TYPE_STRING:
		return Global.story[Global.storystep][ray.get_collider().interaction][2]
	else:
		return Global.story[Global.storystep][ray.get_collider().interaction][2][Global.lang]

func prepare():
	pass

func setbutton(button,text,pos,size,vis):
	button.text = text
	button.position = pos
	button.size = size
	button.visible = vis

func control():
	if not Global.toggle and not Global.clear and not Global.talking:
		if Global.get_matrix(xcell, ycell, Global.room_matrix) == 0:
			if (Input.is_action_pressed("right") or Input.is_action_pressed("left")):
				nextplan_move = Vector2.RIGHT * Input.get_axis("left","right")
				if Global.get_matrix(xcell+Input.get_axis("left","right"), ycell, Global.room_matrix) != 999:
					can_move = true
					if nextplan_move == Vector2.RIGHT and $RightRay.is_colliding():
						await get_tree().create_timer(del).timeout
						if $RightRay.get_collider().can_move and not $RightRay.get_collider().moving:
							move_step(nextplan_move)
							await get_tree().create_timer(Global.mini_delay).timeout
					elif nextplan_move == Vector2.LEFT and $LeftRay.is_colliding():
						await get_tree().create_timer(del).timeout
						if $LeftRay.get_collider().can_move  and not $LeftRay.get_collider().moving:
							move_step(nextplan_move)
							await get_tree().create_timer(Global.mini_delay).timeout
					else:
						move_step(nextplan_move)

			if (Input.is_action_pressed("up") or Input.is_action_pressed("down")):
				nextplan_move = Vector2.DOWN * Input.get_axis("up","down")
				if Global.get_matrix(xcell, ycell+Input.get_axis("up","down"), Global.room_matrix) != 999:
					can_move = true
					if nextplan_move == Vector2.UP and $UpRay.is_colliding():
						await get_tree().create_timer(del).timeout
						if $UpRay.get_collider().can_move  and not $UpRay.get_collider().moving:
							move_step(nextplan_move)
							await get_tree().create_timer(Global.mini_delay).timeout
					elif nextplan_move == Vector2.DOWN and $DownRay.is_colliding():
						await get_tree().create_timer(del).timeout
						if $DownRay.get_collider().can_move  and not $DownRay.get_collider().moving:
							move_step(nextplan_move)
							await get_tree().create_timer(Global.mini_delay).timeout
					else:
						move_step(nextplan_move)

		else:
			if (Input.is_action_pressed("right") or Input.is_action_pressed("left")):
				nextplan_move = Vector2.RIGHT * Input.get_axis("left","right")
				if (Global.get_matrix(xcell, ycell, Global.room_matrix) == Global.get_matrix(xcell +Input.get_axis("left","right"), ycell, Global.room_matrix) \
				or Global.get_matrix(xcell + Input.get_axis("left","right"), ycell, Global.room_matrix) == 0):
					can_move = true
					if nextplan_move == Vector2.RIGHT and $RightRay.is_colliding():
						await get_tree().create_timer(del).timeout
						if $RightRay.get_collider().can_move and not $RightRay.get_collider().moving:
							move_step(nextplan_move)
							await get_tree().create_timer(Global.mini_delay).timeout
					elif nextplan_move == Vector2.LEFT and $LeftRay.is_colliding():
						await get_tree().create_timer(del).timeout
						if $LeftRay.get_collider().can_move and not $LeftRay.get_collider().moving:
							move_step(nextplan_move)
							await get_tree().create_timer(Global.mini_delay).timeout
					else:
						move_step(nextplan_move)

			elif (Input.is_action_pressed("down") or Input.is_action_pressed("up")):
				nextplan_move = Vector2.DOWN * Input.get_axis("up","down")
				if (Global.get_matrix(xcell, ycell, Global.room_matrix) == Global.get_matrix(xcell, ycell + Input.get_axis("up","down"), Global.room_matrix) \
				or Global.get_matrix(xcell , ycell + Input.get_axis("up","down"), Global.room_matrix) == 0):
					can_move = true
					if nextplan_move == Vector2.DOWN and $DownRay.is_colliding():
						await get_tree().create_timer(del).timeout
						if $DownRay.get_collider().can_move and not $DownRay.get_collider().moving:
							move_step(nextplan_move)
							await get_tree().create_timer(Global.mini_delay).timeout 
					elif nextplan_move == Vector2.UP and $UpRay.is_colliding():
						await get_tree().create_timer(del).timeout
						if $UpRay.get_collider().can_move and not $UpRay.get_collider().moving:
							move_step(nextplan_move)
							await get_tree().create_timer(Global.mini_delay).timeout
					else:
						move_step(nextplan_move)

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

func wiggle():
	if not wiggling:
		wiggling = true
		while int(position.x) % tile_size == 0 and int(position.y) % tile_size == 0:
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

func _ready():
	prepare()
	wiggle()
	move_step(Vector2.ZERO)

func interact(ray):
		nextplan_move = Vector2(0,0)
		if ray == $RightRay:
				t1=3
				ray.get_collider().t1 = 2
		if ray == $UpRay:
				t1=0
				ray.get_collider().t1 = 1
		if ray == $LeftRay:
				t1=2
				ray.get_collider().t1 = 3
		if ray == $DownRay:
				t1=1
				ray.get_collider().t1 = 0
		ray.get_collider().nextplan_move= Vector2.ZERO
		Global.talking = true
		match Global.story[Global.storystep][ray.get_collider().interaction][0]:
			0:
				$Camera2D/TextBox.texture = load("res://images/lavbox.png")
				$Camera2D/TextBox/icon.position = Vector2(324,-216)
				$Camera2D/TextBox/Textname.position = Vector2(412,-36)
				$Camera2D/TextBox/Textname.self_modulate = Color(0.695, 0.478, 1.0, 1.0)
				$Camera2D/TextBox/Textname/text.text = (["Lavender","Lavender","·𐑤𐑨𐑝𐑩𐑯𐑛𐑼"])[Global.lang]
				$Camera2D/TextBox/icon.visible = 1
				$Camera2D/TextBox/Textname.visible = 1
				$Camera2D/TextBox/icon.texture = load("res://images/lavicon"+str(Global.story[Global.storystep][ray.get_collider().interaction][1])+".png")
			1:
				$Camera2D/TextBox.texture = load("res://images/soapbox.png")
				$Camera2D/TextBox/icon.position = Vector2(0,-216)
				$Camera2D/TextBox/Textname.position = Vector2(0,-36)
				$Camera2D/TextBox/Textname.self_modulate = Color(0.929, 0.753, 1.0)
				$Camera2D/TextBox/Textname/text.text = (["Soap","Soap","·𐑕𐑴𐑐"])[Global.lang]
				$Camera2D/TextBox/icon.visible = 1
				$Camera2D/TextBox/Textname.visible = 1
				$Camera2D/TextBox/icon.texture = load("res://images/soapicon"+str(Global.story[Global.storystep][ray.get_collider().interaction][1])+".png")
			2:
				$Camera2D/TextBox.texture = load("res://images/wbbox.png")
				$Camera2D/TextBox/icon.position = Vector2(0,-216)
				$Camera2D/TextBox/Textname.position = Vector2(0,-36)
				$Camera2D/TextBox/Textname.self_modulate = Color(0.847, 0.443, 0.926, 1.0)
				$Camera2D/TextBox/Textname/text.text = (["Winterblush","Winterblush","·𐑢𐑦𐑯𐑑𐑼𐑚𐑤𐑳𐑖"])[Global.lang]
				$Camera2D/TextBox/icon.visible = 1
				$Camera2D/TextBox/Textname.visible = 1
				$Camera2D/TextBox/icon.texture = load("res://images/wbicon"+str(Global.story[Global.storystep][ray.get_collider().interaction][1])+".png")
			3:
				$Camera2D/TextBox.texture = load("res://images/petalbox.png")
				$Camera2D/TextBox/icon.position = Vector2(0,-216)
				$Camera2D/TextBox/Textname.position = Vector2(0,-36)
				$Camera2D/TextBox/Textname.self_modulate = Color(0.697, 0.531, 0.974, 1.0)
				$Camera2D/TextBox/Textname/text.text = (["Petal","Petal","·𐑐𐑧𐑑𐑩𐑤"])[Global.lang]
				$Camera2D/TextBox/icon.visible = 1
				$Camera2D/TextBox/Textname.visible = 1
				$Camera2D/TextBox/icon.texture = load("res://images/petalicon"+str(Global.story[Global.storystep][ray.get_collider().interaction][1])+".png")
			4:
				$Camera2D/TextBox.texture = load("res://images/lavbox.png")
				$Camera2D/TextBox/icon.position = Vector2(324,-216)
				
				$Camera2D/TextBox/Textname.position = Vector2(412,-36)
				$Camera2D/TextBox/Textname.self_modulate = Color(0.695, 0.478, 1.0, 1.0)
				$Camera2D/TextBox/Textname/text.text = (["Lavender","Lavender","·𐑤𐑨𐑝𐑩𐑯𐑛𐑼"])[Global.lang]
				$Camera2D/TextBox/icon.texture = load("res://images/lavicon1"+str(Global.story[Global.storystep][ray.get_collider().interaction][1])+".png")
				$Camera2D/TextBox/icon.visible = 1
				$Camera2D/TextBox/Textname.visible = 1
			5:
				$Camera2D/TextBox.texture = load("res://images/lavbox.png")
				
				$Camera2D/TextBox/Textname.visible = 0
				$Camera2D/TextBox/icon.visible = 0

		match Global.story[Global.storystep][ray.get_collider().interaction][3]:
			0:
				setbutton($Camera2D/TextBox/Button0,">",Vector2(504,54),Vector2(36,24),1)
				$Camera2D/TextBox/text.text = e(ray)
				$Camera2D/TextBox/Button1.visible = 0
				$Camera2D/TextBox/Button2.visible = 0
				$Camera2D/TextBox/Button3.visible = 0
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						ray.get_collider().interaction=Global.story[Global.storystep][ray.get_collider().interaction][4]
					on = false
				else:
					on = true
			2:
				setbutton($Camera2D/TextBox/Button0,Global.story[Global.storystep][ray.get_collider().interaction][4][Global.lang],Vector2(36,24),Vector2(216,24),1)
				setbutton($Camera2D/TextBox/Button1,Global.story[Global.storystep][ray.get_collider().interaction][6][Global.lang],Vector2(36,60),Vector2(216,24),1)
				$Camera2D/TextBox/Button2.visible = 0
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/text.text = e(ray)
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						ray.get_collider().interaction=Global.story[Global.storystep][ray.get_collider().interaction][5]
					on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					ray.get_collider().interaction=Global.story[Global.storystep][ray.get_collider().interaction][7]
			3:
				setbutton($Camera2D/TextBox/Button0,Global.story[Global.storystep][ray.get_collider().interaction][4][Global.lang],Vector2(36,24),Vector2(216,24),1)
				setbutton($Camera2D/TextBox/Button1,Global.story[Global.storystep][ray.get_collider().interaction][6][Global.lang],Vector2(216,24),Vector2(216,24),1)
				setbutton($Camera2D/TextBox/Button2,Global.story[Global.storystep][ray.get_collider().interaction][8][Global.lang],Vector2(162,60),Vector2(216,24),1)
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/text.text = e(ray)
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						ray.get_collider().interaction=Global.story[Global.storystep][ray.get_collider().interaction][5]
						on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					ray.get_collider().interaction=Global.story[Global.storystep][ray.get_collider().interaction][7]
				if $Camera2D/TextBox/Button2.button_pressed:
					ray.get_collider().interaction=Global.story[Global.storystep][ray.get_collider().interaction][9]
			4:
				setbutton($Camera2D/TextBox/Button0,Global.story[Global.storystep][ray.get_collider().interaction][4][Global.lang],Vector2(36,24),Vector2(216,24),1)
				setbutton($Camera2D/TextBox/Button1,Global.story[Global.storystep][ray.get_collider().interaction][6][Global.lang],Vector2(216,24),Vector2(216,24),1)
				setbutton($Camera2D/TextBox/Button2,Global.story[Global.storystep][ray.get_collider().interaction][8][Global.lang],Vector2(36,60),Vector2(216,24),1)
				setbutton($Camera2D/TextBox/Button3,Global.story[Global.storystep][ray.get_collider().interaction][10][Global.lang],Vector2(216,60),Vector2(216,24),1)
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						ray.get_collider().interaction=Global.story[Global.storystep][ray.get_collider().interaction][5]
					on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					ray.get_collider().interaction=Global.story[Global.storystep][ray.get_collider().interaction][7]
				if $Camera2D/TextBox/Button2.button_pressed:
					ray.get_collider().interaction=Global.story[Global.storystep][ray.get_collider().interaction][9]
				if $Camera2D/TextBox/Button3.button_pressed:
					ray.get_collider().interaction=Global.story[Global.storystep][ray.get_collider().interaction][11]

		$Camera2D/TextBox.visible = 1
		$Camera2D/pause.visible = 0
		$Camera2D/Control.visible = 0
		$Camera2D/minimap.visible = 0
		$Camera2D/helf.visible = 0

func raycheck():
	if $LeftRay.is_colliding() and $LeftRay.get_collider().interaction != 0:
		interact($LeftRay)
	elif $UpRay.is_colliding() and $UpRay.get_collider().interaction != 0:
		interact($UpRay)
	elif  $RightRay.is_colliding() and $RightRay.get_collider().interaction != 0:
		interact($RightRay)
	elif $DownRay.is_colliding() and $DownRay.get_collider().interaction != 0:
		interact($DownRay)
	else:
		$Camera2D/TextBox.visible = 0
		$Camera2D/pause.visible = 1
		$Camera2D/Control.visible = 1
		$Camera2D/minimap.visible = 1
		$Camera2D/helf.visible = 1
		Global.talking = false

func _process(delta):
	del = delta
	$Camera2D/helf.value = Global.health
	$Camera2D/helf/hunga.value = Global.hunger
	$Camera2D/helf/wata.value = Global.water
	$Camera2D/helf/eepy.value = Global.sleep

	if moving or not (int(position.x) % tile_size == 0 and int(position.y) % tile_size == 0):
		can_move = false
		hurten = false
		return
	elif not wiggling:
		wiggle()

	raycheck()

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

	if (not hurten):
		Global.health  -= Global.get_matrix(xcell, ycell, Global.hurt_matrix)
		if Global.health <= 0:
			Global.health = 100
			get_tree().change_scene_to_file("res://Start.tscn")
		hurten = true

	if Global.hunger < 21:
		$Camera2D/helf/RichTextLabel.text = "Hungry"
	elif Global.water < 21:
		$Camera2D/helf/RichTextLabel.text = "Thristy"
	elif Global.sleep < 21:
		$Camera2D/helf/RichTextLabel.text = "Sleepy"
	elif Global.hunger < 21 and Global.water < 21 and Global.sleep < 21:
		$Camera2D/helf/RichTextLabel.text = "WTH"
	else:
		$Camera2D/helf/RichTextLabel.text = "Fine"

func move_step(dir: Vector2) -> void:
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
	if dir != Vector2.ZERO:
		Global.moves += 1
		if Global.moves % 9 == 0 and Global.water > 0:
			Global.water -= 4
		if Global.moves % 13 == 0 and Global.hunger > 0:
			Global.hunger -= 3
		if Global.moves % 17 == 0 and  Global.sleep > 0:
			Global.sleep -= 2
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
