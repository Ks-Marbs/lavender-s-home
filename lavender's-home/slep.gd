extends Area2D
var numb=0.0
var n=0
var interaction = 0
var item = 1
var t1 = 0
var dim = false
var nextplan_move:= Vector2.ZERO
var can_move := false
var moving := false
var on := true
var isplayer := false
var active = false
var xcell := (position.x - (int(position.x) % 36)) / 36
var ycell := (position.y - (int(position.y) % 36)) / 36
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func check():
	if (($RightRay.is_colliding() and $RightRay.get_collider().isplayer and $RightRay.get_collider().t1==2) and Global.get_matrix(xcell,ycell,Global.room_matrix)==0) or\
 (($RightRay.is_colliding() and $RightRay.get_collider().isplayer and $RightRay.get_collider().t1==2) and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell+1,ycell,Global.room_matrix)) or Global.get_matrix(xcell+1,ycell,Global.room_matrix) == 0)) : #aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
		return true
	else:
		return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dim:
		if Global.sleeping:
			if Global.black<1.5: Global.black += 0.02
			else: Global.black = 1; Global.sleeping = false; Global.sleep = 100
		else:
			if Global.black>0: Global.black -= 0.01
			else: Global.black = 0
	if check():
		if Global.storystep == 2:
			$t.visible_characters += 1
			if Input.is_action_just_pressed("in") and interaction == 0:
				Global.sleeping = true
				interaction = 1
		if Global.storystep == 3:
			if Input.is_action_just_pressed("in"):
				dim = true
	else:
		$t.visible_characters = 0
	numb+=delta
	n = floori(numb/2)%4
	$Sprite2d.texture = load("res://images/sleep"+str(n)+".png")
	if Global.sleeping:
		$Sprite2d.visible = 1
		Global.sleep = 100
	else: $Sprite2d.visible = 0
	pass
