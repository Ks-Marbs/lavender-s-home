extends Area2D
var wiggling = false
var nextplan_move = Vector2.UP
var text_mat:= []
var can_move := false
var isplayer := false
var yes=true
var on=false
var isgoal=false
var time= 1
var t1 = 0
var t2 = 0
var vis = 0.01
var active = false
var interaction:= 0
var item= 0
var xcell := (position.x - (int(position.x) % 36)) / 36
var ycell := (position.y - (int(position.y) % 36)) / 36

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
		if Input.is_action_pressed("in") and on:
			on = false
			if interaction == 0: 
				interaction = 1
				return
			elif text_mat[interaction][3]==0: 
				interaction = text_mat[interaction][4]
				if interaction != 0: Global.soap = interaction
				return
		else:
			on = true
	else:
		vis = 0

func _ready() -> void:
	wiggle()
#From here on is just game
#plan: [step][0-text 1-character(see list) 2-icon(see list) 3-number of buttons 4,6,8... button texts 5,7,9... button leads to step x
	text_mat=[[0,0,0],[">\"Oh...Hi [Lavender]... you think i should sign up?\"",1,0,0,2],["",0,0,1,">yes",3,">no",6],[">\"Sure, why not?\"",0,0,0,4],[">\"Really? You actually think I'm that strong and athletic to sign up?\"",1,0,0,5],[">You laugh slightly",0,0,0,10],[">\"Hmmm...not really\"",0,0,0,7],[">\"That's fair, I doubt mom would sign up anyway\"",1,0,0,8],[">\"She'll probably sign Winter instead\"",1,0,0,9],[">You nod slightly",0,0,0,10],[">\"Maybe I could go?\"",0,0,0,11],[">\"I doubt...It's like a camp...except with more competition\"",1,0,0,12],[">\"It's a competition, Lavender. You don't like competitions\"",1,0,0,13],[">You say nothing, but it's true",0,0,0,0]]
#charactres : 0-lav 1-soap 2-WB 3- Petal 4-???
#icons: 0-happy 1- sad 2- idk
