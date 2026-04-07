extends Area2D
var interaction=0
var can_move := false
var isplayer := false
var yes=true
var time= 2
var item = 0
var vis = 0.05
var active = false
var xcell := (position.x - (int(position.x) % 36)) / 36
var ycell := (position.y - (int(position.y) % 36)) / 36
func _ready() -> void:
	pass


func check():
	if(($LeftRay.is_colliding() and $LeftRay.get_collider().isplayer and $LeftRay.get_collider().t1==3) or\
	 ($RightRay.is_colliding() and $RightRay.get_collider().isplayer and $RightRay.get_collider().t1==2) or\
	($UpRay.is_colliding() and $UpRay.get_collider().isplayer and $UpRay.get_collider().t1==1) or\
	($DownRay.is_colliding() and $DownRay.get_collider().isplayer and $DownRay.get_collider().t1==0)) and Global.get_matrix(xcell,ycell,Global.room_matrix)==0 or\
	(($LeftRay.is_colliding() and $LeftRay.get_collider().isplayer and$LeftRay.get_collider().t1==3) and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell-1,ycell,Global.room_matrix)) or Global.get_matrix(xcell-1,ycell,Global.room_matrix) == 0)) or\
	 (($RightRay.is_colliding() and $RightRay.get_collider().isplayer and$RightRay.get_collider().t1==2) and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell+1,ycell,Global.room_matrix)) or Global.get_matrix(xcell+1,ycell,Global.room_matrix) == 0)) or\
	(($UpRay.is_colliding() and $UpRay.get_collider().isplayer and$UpRay.get_collider().t1==1)  and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell,ycell-1,Global.room_matrix)) or Global.get_matrix(xcell,ycell-1,Global.room_matrix) == 0)) or\
	(($DownRay.is_colliding() and $DownRay.get_collider().isplayer and$DownRay.get_collider().t1==0) and ((Global.get_matrix(xcell,ycell,Global.room_matrix)==Global.get_matrix(xcell,ycell+1,Global.room_matrix)) or Global.get_matrix(xcell,ycell+1,Global.room_matrix) == 0)):
		return true
	else:
		return false

func _process(delta: float) -> void:
	$RichTextLabel.visible_characters = vis
	if check():
		if Input.is_action_pressed("in"):
			match str(self.name)[0]:
				"s":
					match Global.level:
						1:
							get_tree().change_scene_to_file("res://level_2.tscn")
							Global.level = 2
						2:
							get_tree().change_scene_to_file("res://level_1.tscn")
							Global.level = 1
				"d":
					match Global.level:
						3:
							get_tree().change_scene_to_file("res://level_2.tscn")
							Global.level = 2
						2:
							get_tree().change_scene_to_file("res://level_3.tscn")
							Global.level = 3
		vis += 0.05

	else:
		vis = 0
#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
