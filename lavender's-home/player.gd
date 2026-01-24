extends Area2D
var isbox := false
var on := false
var hurten := false
var del = 0.18
var yes = true
var isplayer := true
var isgoal := false
var tile_size := 36
var step_size := 4.5
var last_move := Vector2.ONE
var nextplan_move := Vector2.ONE
var moving := false
var can_move := false
var xcell := (position.x - (int(position.x) % 36)) / 36
var ycell := (position.y - (int(position.y) % 36)) / 36
var sprite:=[[[[[[]]]]]]
var t1:=0 # direction
var t2:= 0 #frame
var wiggling := false

func prepare():
	for i in range(1):
		sprite.append([])
		for j in range(1):
			sprite[i].append([])
			for k in range(1):
				sprite[i][j].append(load("res://images/lav"+"1"+"."+"1"+"."+"1"+".png"))

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


func _process(delta):
	del = delta
	$Camera2D/helf.value = Global.health
	$Camera2D/helf/hunga.value = Global.hunger
	$Camera2D/helf/wata.value = Global.water
	$Camera2D/helf/eepy.value = Global.sleep
	$Camera2D/helf/RichTextLabel.text = str(Global.moves)

	if moving or not (int(position.x) % tile_size == 0 and int(position.y) % tile_size == 0):
		can_move = false
		hurten = false
		return
	elif not wiggling:
		wiggle()

	if Global.get_matrix(xcell,ycell,Global.special_matrix) == 1:
		if may_slide(nextplan_move) == true and nextplan_move != Vector2.ZERO:
			ice_step(nextplan_move)
		else:
			control()

	elif Global.get_matrix(xcell,ycell,Global.special_matrix) == 2:
		if may_slide(Vector2.UP) == true:
			ice_step(Vector2.UP)
			nextplan_move=Vector2.UP
		else:
			control()

	elif Global.get_matrix(xcell,ycell,Global.special_matrix) == 3:
		if  may_slide(Vector2.DOWN) == true:
			ice_step(Vector2.DOWN)
			nextplan_move=Vector2.DOWN
		else:
			control()

	elif Global.get_matrix(xcell,ycell,Global.special_matrix) == 4:
		if may_slide(Vector2.LEFT) == true:
			ice_step(Vector2.LEFT)
			nextplan_move=Vector2.LEFT
		else:
			control()

	elif Global.get_matrix(xcell,ycell,Global.special_matrix) == 5:
		if  may_slide(Vector2.RIGHT) == true:
			ice_step(Vector2.RIGHT)
			nextplan_move=Vector2.RIGHT
		else:
			control()

	elif Global.get_matrix(xcell, ycell, Global.special_matrix) == 0:
		control()

	if (not hurten):
		Global.health  -= Global.get_matrix(xcell, ycell, Global.hurt_matrix)
		if Global.health <= 0:
			Global.health = 100
			get_tree().change_scene_to_file("res://Start.tscn")
		hurten = true

	if $RightRay.is_colliding() and $RightRay.get_collider().interaction != 0:
		nextplan_move = Vector2(0,0)
		t1 = 3
		$RightRay.get_collider().nextplan_move= Vector2.ZERO
		$RightRay.get_collider().t1 = 2
		Global.talking = true
		match $RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][1]:
			0:
				$Camera2D/TextBox.texture = load("res://images/lavbox.png")
				$Camera2D/TextBox/text.text = $RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][0]
				$Camera2D/TextBox/Textname.position = Vector2(360,-36)
				$Camera2D/TextBox/Textname.self_modulate = Color(0.694, 0.478, 1.0)
				$Camera2D/TextBox/Textname/text.text = "Lavender"
			1:
				$Camera2D/TextBox.texture = load("res://images/soapbox.png")
				$Camera2D/TextBox/text.text = $RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][0]
				$Camera2D/TextBox/Textname.position = Vector2(0,-36)
				$Camera2D/TextBox/Textname.self_modulate = Color(0.929, 0.753, 1.0)
				$Camera2D/TextBox/Textname/text.text = "Soap"
		match $RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][3]:
			0:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 0
				$Camera2D/TextBox/Button2.visible = 0
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/Button0.size = Vector2(36,24)
				$Camera2D/TextBox/Button0.text = ">"
				$Camera2D/TextBox/Button0.position = Vector2(420,66)
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$RightRay.get_collider().interaction=$RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][4]
					on = false
				else:
					on = true
			1:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 1
				$Camera2D/TextBox/Button2.visible = 0
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/Button0.size = Vector2(180,24)
				$Camera2D/TextBox/Button0.position = Vector2(36,24)
				$Camera2D/TextBox/Button1.position = Vector2(36,60)
				$Camera2D/TextBox/Button0.text = $RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][4]
				$Camera2D/TextBox/Button1.text = $RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][6]
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$RightRay.get_collider().interaction=$RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][5]
					on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					$RightRay.get_collider().interaction=$RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][7]
			2:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 1
				$Camera2D/TextBox/Button2.visible = 1
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/Button0.size = Vector2(180,24)
				$Camera2D/TextBox/Button0.position = Vector2(36,24)
				$Camera2D/TextBox/Button1.position = Vector2(252,24)
				$Camera2D/TextBox/Button2.position = Vector2(144,60)
				$Camera2D/TextBox/Button0.text = $RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][4]
				$Camera2D/TextBox/Button1.text = $RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][6]
				$Camera2D/TextBox/Button2.text = $RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][8]
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$RightRay.get_collider().interaction=$RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][5]
						on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					$RightRay.get_collider().interaction=$RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][7]
				if $Camera2D/TextBox/Button2.button_pressed:
					$RightRay.get_collider().interaction=$RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][9]
			3:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 1
				$Camera2D/TextBox/Button2.visible = 1
				$Camera2D/TextBox/Button3.visible = 1
				$Camera2D/TextBox/Button0.size = Vector2(180,24)
				$Camera2D/TextBox/Button0.position = Vector2(36,24)
				$Camera2D/TextBox/Button1.position = Vector2(252,24)
				$Camera2D/TextBox/Button2.position = Vector2(36,60)
				$Camera2D/TextBox/Button3.position = Vector2(252,60)
				$Camera2D/TextBox/Button0.text = $RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][4]
				$Camera2D/TextBox/Button1.text = $RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][6]
				$Camera2D/TextBox/Button2.text = $RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][8]
				$Camera2D/TextBox/Button3.text = $RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][10]
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$RightRay.get_collider().interaction=$RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][5]
					on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					$RightRay.get_collider().interaction=$RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][7]
				if $Camera2D/TextBox/Button2.button_pressed:
					$RightRay.get_collider().interaction=$RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][9]
				if $Camera2D/TextBox/Button3.button_pressed:
					$RightRay.get_collider().interaction=$RightRay.get_collider().text_mat[$RightRay.get_collider().interaction][11]

		$Camera2D/TextBox.visible = 1
		$Camera2D/pause.visible = 0
		$Camera2D/Control.visible = 0
		$Camera2D/minimap.visible = 0
		$Camera2D/helf.visible = 0
	elif $LeftRay.is_colliding() and $LeftRay.get_collider().interaction != 0:
		nextplan_move = Vector2(0,0)
		t1 = 2
		$LeftRay.get_collider().nextplan_move= Vector2.ZERO
		$LeftRay.get_collider().t1 = 3
		match $LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][1]:
			0:
				$Camera2D/TextBox.texture = load("res://images/lavbox.png")
				$Camera2D/TextBox/text.text = $LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][0]
				$Camera2D/TextBox/Textname.position = Vector2(360,-36)
				$Camera2D/TextBox/Textname.self_modulate = Color(0.694, 0.478, 1.0)
				$Camera2D/TextBox/Textname/text.text = "Lavender"
			1:
				$Camera2D/TextBox.texture = load("res://images/soapbox.png")
				$Camera2D/TextBox/text.text = $LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][0]
				$Camera2D/TextBox/Textname.position = Vector2(0,-36)
				$Camera2D/TextBox/Textname.self_modulate = Color(0.929, 0.753, 1.0)
				$Camera2D/TextBox/Textname/text.text = "Soap"
		match $LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][3]:
			0:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 0
				$Camera2D/TextBox/Button2.visible = 0
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/Button0.size = Vector2(24,24)
				$Camera2D/TextBox/Button0.text = ">"
				$Camera2D/TextBox/Button0.position = Vector2(420,66)
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$LeftRay.get_collider().interaction=$LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][4]
					on = false
				else:
					on = true
			1:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 1
				$Camera2D/TextBox/Button2.visible = 0
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/Button0.size = Vector2(180,24)
				$Camera2D/TextBox/Button0.position = Vector2(36,24)
				$Camera2D/TextBox/Button1.position = Vector2(36,60)
				$Camera2D/TextBox/Button0.text = $LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][4]
				$Camera2D/TextBox/Button1.text = $LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][6]
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$LeftRay.get_collider().interaction=$LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][5]
					on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					$LeftRay.get_collider().interaction=$LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][7]
			2:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 1
				$Camera2D/TextBox/Button2.visible = 1
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/Button0.size = Vector2(180,24)
				$Camera2D/TextBox/Button0.position = Vector2(36,24)
				$Camera2D/TextBox/Button1.position = Vector2(252,24)
				$Camera2D/TextBox/Button2.position = Vector2(144,60)
				$Camera2D/TextBox/Button0.text = $LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][4]
				$Camera2D/TextBox/Button1.text = $LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][6]
				$Camera2D/TextBox/Button2.text = $LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][8]
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$LeftRay.get_collider().interaction=$LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][5]
						on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					$LeftRay.get_collider().interaction=$LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][7]
				if $Camera2D/TextBox/Button2.button_pressed:
					$LeftRay.get_collider().interaction=$LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][9]
			3:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 1
				$Camera2D/TextBox/Button2.visible = 1
				$Camera2D/TextBox/Button3.visible = 1
				$Camera2D/TextBox/Button0.size = Vector2(180,24)
				$Camera2D/TextBox/Button0.position = Vector2(36,24)
				$Camera2D/TextBox/Button1.position = Vector2(252,24)
				$Camera2D/TextBox/Button2.position = Vector2(36,60)
				$Camera2D/TextBox/Button3.position = Vector2(252,60)
				$Camera2D/TextBox/Button0.text = $LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][4]
				$Camera2D/TextBox/Button1.text = $LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][6]
				$Camera2D/TextBox/Button2.text = $LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][8]
				$Camera2D/TextBox/Button3.text = $LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][10]
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$LeftRay.get_collider().interaction=$LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][5]
						on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					$LeftRay.get_collider().interaction=$LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][7]
				if $Camera2D/TextBox/Button2.button_pressed:
					$LeftRay.get_collider().interaction=$LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][9]
				if $Camera2D/TextBox/Button3.button_pressed:
					$LeftRay.get_collider().interaction=$LeftRay.get_collider().text_mat[$LeftRay.get_collider().interaction][11]

		$Camera2D/TextBox.visible = 1
		$Camera2D/pause.visible = 0
		$Camera2D/Control.visible = 0
		$Camera2D/minimap.visible = 0
		$Camera2D/helf.visible = 0
	elif $UpRay.is_colliding() and $UpRay.get_collider().interaction != 0:
		nextplan_move = Vector2(0,0)
		t1 = 0
		$UpRay.get_collider().nextplan_move= Vector2.ZERO
		$UpRay.get_collider().t1 = 1
		match $UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][1]:
			0:
				$Camera2D/TextBox.texture = load("res://images/lavbox.png")
				$Camera2D/TextBox/text.text = $UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][0]
				$Camera2D/TextBox/Textname.position = Vector2(360,-36)
				$Camera2D/TextBox/Textname.self_modulate = Color(0.694, 0.478, 1.0)
				$Camera2D/TextBox/Textname/text.text = "Lavender"
			1:
				$Camera2D/TextBox.texture = load("res://images/soapbox.png")
				$Camera2D/TextBox/text.text = $UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][0]
				$Camera2D/TextBox/Textname.position = Vector2(0,-36)
				$Camera2D/TextBox/Textname.self_modulate = Color(0.929, 0.753, 1.0)
				$Camera2D/TextBox/Textname/text.text = "Soap"
		match $UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][3]:
			0:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 0
				$Camera2D/TextBox/Button2.visible = 0
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/Button0.size = Vector2(24,24)
				$Camera2D/TextBox/Button0.text = ">"
				$Camera2D/TextBox/Button0.position = Vector2(420,66)
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$UpRay.get_collider().interaction=$UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][4]
					on = false
				else:
					on = true
			1:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 1
				$Camera2D/TextBox/Button2.visible = 0
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/Button0.size = Vector2(180,24)
				$Camera2D/TextBox/Button0.position = Vector2(36,24)
				$Camera2D/TextBox/Button1.position = Vector2(36,60)
				$Camera2D/TextBox/Button0.text = $UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][4]
				$Camera2D/TextBox/Button1.text = $UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][6]
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$UpRay.get_collider().interaction=$UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][5]
						on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					$UpRay.get_collider().interaction=$UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][7]
			2:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 1
				$Camera2D/TextBox/Button2.visible = 1
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/Button0.size = Vector2(180,24)
				$Camera2D/TextBox/Button0.position = Vector2(36,24)
				$Camera2D/TextBox/Button1.position = Vector2(252,24)
				$Camera2D/TextBox/Button2.position = Vector2(144,60)
				$Camera2D/TextBox/Button0.text = $UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][4]
				$Camera2D/TextBox/Button1.text = $UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][6]
				$Camera2D/TextBox/Button2.text = $UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][8]
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$UpRay.get_collider().interaction=$UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][5]
						on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					$UpRay.get_collider().interaction=$UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][7]
				if $Camera2D/TextBox/Button2.button_pressed:
					$UpRay.get_collider().interaction=$UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][9]
			3:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 1
				$Camera2D/TextBox/Button2.visible = 1
				$Camera2D/TextBox/Button3.visible = 1
				$Camera2D/TextBox/Button0.size = Vector2(180,24)
				$Camera2D/TextBox/Button0.position = Vector2(36,24)
				$Camera2D/TextBox/Button1.position = Vector2(252,24)
				$Camera2D/TextBox/Button2.position = Vector2(36,60)
				$Camera2D/TextBox/Button3.position = Vector2(252,60)
				$Camera2D/TextBox/Button0.text = $UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][4]
				$Camera2D/TextBox/Button1.text = $UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][6]
				$Camera2D/TextBox/Button2.text = $UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][8]
				$Camera2D/TextBox/Button3.text = $UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][10]
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$UpRay.get_collider().interaction=$UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][5]
						on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					$UpRay.get_collider().interaction=$UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][7]
				if $Camera2D/TextBox/Button2.button_pressed:
					$UpRay.get_collider().interaction=$UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][9]
				if $Camera2D/TextBox/Button3.button_pressed:
					$UpRay.get_collider().interaction=$UpRay.get_collider().text_mat[$UpRay.get_collider().interaction][11]

		$Camera2D/TextBox.visible = 1
		$Camera2D/pause.visible = 0
		$Camera2D/Control.visible = 0
		$Camera2D/minimap.visible = 0
		$Camera2D/helf.visible = 0
	elif $DownRay.is_colliding() and $DownRay.get_collider().interaction != 0:
		nextplan_move = Vector2(0,0)
		t1 = 1
		$DownRay.get_collider().nextplan_move= Vector2.ZERO
		$DownRay.get_collider().t1 = 0
		match $DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][1]:
			0:
				$Camera2D/TextBox.texture = load("res://images/lavbox.png")
				$Camera2D/TextBox/text.text = $DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][0]
				$Camera2D/TextBox/Textname.position = Vector2(360,-36)
				$Camera2D/TextBox/Textname.self_modulate = Color(0.694, 0.478, 1.0)
				$Camera2D/TextBox/Textname/text.text = "Lavender"
			1:
				$Camera2D/TextBox.texture = load("res://images/soapbox.png")
				$Camera2D/TextBox/text.text = $DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][0]
				$Camera2D/TextBox/Textname.position = Vector2(0,-36)
				$Camera2D/TextBox/Textname.self_modulate = Color(0.929, 0.753, 1.0)
				$Camera2D/TextBox/Textname/text.text = "Soap"
		match $DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][3]:
			0:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 0
				$Camera2D/TextBox/Button2.visible = 0
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/Button0.size = Vector2(24,24)
				$Camera2D/TextBox/Button0.text = ">"
				$Camera2D/TextBox/Button0.position = Vector2(420,66)
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$DownRay.get_collider().interaction=$DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][4]
					on = false
					
				else:
					on = true
			1:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 1
				$Camera2D/TextBox/Button2.visible = 0
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/Button0.size = Vector2(180,24)
				$Camera2D/TextBox/Button0.position = Vector2(36,24)
				$Camera2D/TextBox/Button1.position = Vector2(36,60)
				$Camera2D/TextBox/Button0.text = $DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][4]
				$Camera2D/TextBox/Button1.text = $DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][6]
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$DownRay.get_collider().interaction=$DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][5]
						on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					$DownRay.get_collider().interaction=$DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][7]
			2:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 1
				$Camera2D/TextBox/Button2.visible = 1
				$Camera2D/TextBox/Button3.visible = 0
				$Camera2D/TextBox/Button0.size = Vector2(180,24)
				$Camera2D/TextBox/Button0.position = Vector2(36,24)
				$Camera2D/TextBox/Button1.position = Vector2(252,24)
				$Camera2D/TextBox/Button2.position = Vector2(144,60)
				$Camera2D/TextBox/Button0.text = $DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][4]
				$Camera2D/TextBox/Button1.text = $DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][6]
				$Camera2D/TextBox/Button2.text = $DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][8]
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$DownRay.get_collider().interaction=$DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][5]
					on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					$DownRay.get_collider().interaction=$DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][7]
				if $Camera2D/TextBox/Button2.button_pressed:
					$DownRay.get_collider().interaction=$DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][9]
			3:
				$Camera2D/TextBox/Button0.visible = 1
				$Camera2D/TextBox/Button1.visible = 1
				$Camera2D/TextBox/Button2.visible = 1
				$Camera2D/TextBox/Button3.visible = 1
				$Camera2D/TextBox/Button0.size = Vector2(180,24)
				$Camera2D/TextBox/Button0.position = Vector2(36,24)
				$Camera2D/TextBox/Button1.position = Vector2(252,24)
				$Camera2D/TextBox/Button2.position = Vector2(36,60)
				$Camera2D/TextBox/Button3.position = Vector2(252,60)
				$Camera2D/TextBox/Button0.text = $DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][4]
				$Camera2D/TextBox/Button1.text = $DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][6]
				$Camera2D/TextBox/Button2.text = $DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][8]
				$Camera2D/TextBox/Button3.text = $DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][10]
				if $Camera2D/TextBox/Button0.button_pressed:
					if on:
						$DownRay.get_collider().interaction=$DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][5]
						on = false
				else:
					on = true
				if $Camera2D/TextBox/Button1.button_pressed:
					$DownRay.get_collider().interaction=$DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][7]
				if $Camera2D/TextBox/Button2.button_pressed:
					$DownRay.get_collider().interaction=$DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][9]
				if $Camera2D/TextBox/Button3.button_pressed:
					$DownRay.get_collider().interaction=$DownRay.get_collider().text_mat[$DownRay.get_collider().interaction][11]

		$Camera2D/TextBox.visible = 1
		$Camera2D/pause.visible = 0
		$Camera2D/Control.visible = 0
		$Camera2D/minimap.visible = 0
		$Camera2D/helf.visible = 0
	else:
		$Camera2D/TextBox.visible = 0
		$Camera2D/pause.visible = 1
		$Camera2D/Control.visible = 1
		$Camera2D/minimap.visible = 1
		$Camera2D/helf.visible = 1
		Global.talking = false

	


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
		if Global.moves % 32 == 0:
			Global.water -= 1
		if Global.moves % 49 == 0:
			Global.hunger -= 1
		if Global.moves % 50 == 0:
			Global.sleep -= 1
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
