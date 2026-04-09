extends Sprite2D
var numb=0.0
var n=0
var active = false
var xcell := (position.x - (int(position.x) % 36)) / 36
var ycell := (position.y - (int(position.y) % 36)) / 36
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func check():
	if (($RightRay.is_colliding() and $RightRay.get_collider().isplayer and $RightRay.get_collider().t1==2) and Global.get_matrix(xcell,ycell,Global.room_matrix)==0) or\
 (($RightRay.is_colliding() and $RightRay.get_collider().isplayer and$RightRay.get_collider().t1==2) and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell+1,ycell,Global.room_matrix)) or Global.get_matrix(xcell+1,ycell,Global.room_matrix) == 0)) : #aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
		return true
	else:
		return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	numb+=delta
	n = floori(numb/2)%4
	texture = load("res://images/sleep"+str(n)+".png")
	if Global.sleeping: visible = 1
	else: visible = 0
	pass
