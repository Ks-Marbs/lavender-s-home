extends Area2D
var can_move := false
var isplayer := false
var yes=true
var time= 1
var vis = 0.01
var active = false
var interaction:= 0
var xcell := (position.x - (int(position.x) % 36)) / 36
var ycell := (position.y - (int(position.y) % 36)) / 36
func _ready() -> void:
	wiggle()

func wiggle():
	while yes:
		$RichTextLabel.position += Vector2.UP 
		await get_tree().create_timer(time).timeout
		$RichTextLabel.position += Vector2.DOWN 
		await get_tree().create_timer(time).timeout
		
func showtex():
	vis += 0.2

func _process(delta: float) -> void:
	$RichTextLabel.visible_characters = vis
	if(($LeftRay.is_colliding() and $LeftRay.get_collider().isplayer) or\
	 ($RightRay.is_colliding() and $RightRay.get_collider().isplayer) or\
	($UpRay.is_colliding() and $UpRay.get_collider().isplayer) or\
	($DownRay.is_colliding() and $DownRay.get_collider().isplayer)) and Global.get_matrix(xcell,ycell,Global.room_matrix)==0 or\
	(($LeftRay.is_colliding() and $LeftRay.get_collider().isplayer) and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell-1,ycell,Global.room_matrix)) or Global.get_matrix(xcell-1,ycell,Global.room_matrix) == 0)) or\
	 (($RightRay.is_colliding() and $RightRay.get_collider().isplayer) and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell+1,ycell,Global.room_matrix)) or Global.get_matrix(xcell+1,ycell,Global.room_matrix) == 0)) or\
	(($UpRay.is_colliding() and $UpRay.get_collider().isplayer)  and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell,ycell-1,Global.room_matrix)) or Global.get_matrix(xcell,ycell-1,Global.room_matrix) == 0)) or\
	(($DownRay.is_colliding() and $DownRay.get_collider().isplayer) and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell,ycell+1,Global.room_matrix)) or Global.get_matrix(xcell,ycell+1,Global.room_matrix) == 0)):
		active = true
	else:
		active = false

	if active:
		showtex()
		$RichTextLabel.text = (str(self.name) + str(interaction))
		if Input.is_action_just_pressed("interact"):
			interaction += 1
	else:
		interaction = 0
		vis = 0
#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
