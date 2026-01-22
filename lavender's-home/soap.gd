extends Area2D

var text_mat:= []
var can_move := false
var isplayer := false
var yes=true
var time= 1
var vis = 0.01
var active = false
var interaction:= 0
var xcell := (position.x - (int(position.x) % 36)) / 36
var ycell := (position.y - (int(position.y) % 36)) / 36

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
		if Input.is_action_just_pressed("in"):
			if interaction == 0: 
				interaction = Global.soap
				return
			elif text_mat[interaction][3]==0: 
				interaction = text_mat[interaction][4]
				if interaction != 0: Global.soap = interaction
				return
	else:
		vis = 0

func _ready() -> void:
	wiggle()
#From here on is just game
#plan: [step][0-text 1-character(see list) 2-icon(see list) 3-number of buttons 4,6,8... button texts 5,7,9... button leads to step x
	text_mat=[[0,0,0],[">Oh...Hi [Lavender]... you think i should sign up?",1,0,0,2],["",0,0,1,">yes",3,">no",1],[">Sure, why not?",1,0,0,2]]
#charactres : 0-lav 1-soap 2-WB 3- Petal 4-???
#icons: 0-happy 1- sad 2- idk
