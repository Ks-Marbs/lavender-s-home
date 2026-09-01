extends Node
#just adding this so i can make a repoaaaaaaaaaaaaaa
var lang := 0
var black = false
var storystep = 0
var m1 = 1
var m2 = 1
var m3 = 1
var level := 1
var took_stairs := false
var took_door = false
var talking := false
var mini_delay := 0.06
var full_delay := 0
var health := 100
var water := 100
var hunger := 100
var sleep := 100
var wiggle_delay = 4
var room_matrix := []
var special_matrix := []
var hurt_matrix := []
var cols = 17
var rows = 14
var GridT = 0.5
var goals := 0
var fgoals := 0
var toggle = false
var moves := 0
var clear = false
var Soap = [0,0]
var Card = [0]
var Petal = [0,0]
var Winterblush = [0,0]
var x := 0
var y := 0
var loading := false
var sleeping := false
var objective := "Find Petal"
var lan :=["res://images/lang/eng.txt","res://images/lang/port.txt","res://images/lang/shav.txt","res://images/lang/span.txt","res://images/lang/fren.txt","res://images/lang/finl.txt","res://images/lang/bril.txt"]
var story:=[\
	#plan: 0-character(see list) 1-icon(see list) 2-text 3-number of buttons 4,6,8... button texts 5,7,9... button leads to step x

[[0] , ["B",load("res://images/slash0.png"),3,3,3,"0-0"],["A",load("res://images/slash0.png"),0.1,3],["A",load("res://images/slash1.png"),0.2,4],["A",load("res://images/slash2.png"),0.1,5],["A",load("res://images/slash3.png"),0.1,6],["A",load("res://images/slash4.png"),0.1,7],["A",load("res://images/slash5.png"),0.1,8],["A",load("res://images/slash6.png"),0.1,9],["A",load("res://images/slash7.png"),0.1,10],["A",load("res://images/slash8.png"),0.1,11],["A",load("res://images/slash9.png"),0.1,12],["A",load("res://images/slash10.png"),0.04,13],["E",0]], #aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
[[1],[1,1,"1-0",0,2],[0,1,'',2,"y1",3,"n1",8],[0,1,"1-1",0,4],[1,5,"1-2",0,5],[0,5,"dots",0,6],[1,5,"dots",0,7],[0,4,"1-3",0,8],[1,1,"1-4",0,9],[0,1,"1-5",0,10],[1,2,"1-6",0,11],[0,0,"1-7",0,12],[1,5,"dots",0,13],[0,5,"dots",0,14],[1,1,"1-8",0,15],[0,5,'',2,"y2",16,"n2",19],[0,0,"1-9",0,17],[1,4,"1-10",0,18],[5,0,"1-11",0,20],[1,5,"1-12",0,21],[1,5,"1-13",0,22],[5,5,"1-14",0,23],[0,1,"1-15",0,24],[1,5,"1-16",0,25],[1,4,"1-17",0,26],[5,5,"1-18",0,27],[5,2,"1-19",0,28],[1,5,"1-20",0,29],["S",load("res://images/d1.mp3"),6,5,2,"1-21"],["E",0]],
[[2], [3,1,"2-0",0,2],[3,3,"2-1",0,3],[3,4,"2-2",0,4],[2,5,"2-3",0,5],[2,4,"2-4",0,6],[3,3,"2-5",0,7],[3,4,"2-6",0,8],[2,4,"2-7",0,9],[2,4,"2-8",0,10],[3,3,"2-9",0,11],[3,5,"2-10",0,12],[2,5,"2-11",0,13],[2,3,"2-12",0,14],[3,4,"2-13",0,15],[3,3,"2-14",0,16],[2,3,"2-15",0,17],[3,3,"2-16",0,18],[2,4,"2-17",0,19],[6,4,"2-18",0,0]],
[[3],[5,1,"3-0",0,2],[5,1,"3-1",0,3],[2,3,"3-2",0,4],[0,2,"w1",0,5],[2,1,"3-3",0,6],[2,4,"3-4",0,7],[0,5,"dots",0,8],[2,5,"3-5",0,9],[5,0,'',2,"y3",10,"w2",13],[0,5,"y1",0,11],[2,5,"3-6",0,12],[0,5,"y2",0,0],[0,1,"3-7",0,14],[2,4,"3-8",0,15],[0,1,"dots",0,16],[2,2,"3-9",0,0]]]

#charactres : 0-lav 1-soap 2-WB 3- Petal 4-lav eep 5-narrator
#icons: 0-happy 1- sad 2- idk

func get_matrix(a,b,mat):
	if a <= cols and b <= rows and a >= 0 and b >= 0:
		return mat[a][b]
	else:
		return 999


func prepare(n):
	loading = true
	fgoals = 0
	goals = 0
	match Global.storystep:
		0: Soap=[0,50,50,50,50,50,50,0,0,0];Winterblush=[0,50,50,50,50,50,50,0,0,0];Petal=[1,50,50,50,50,15,24,1,0,0]
		1: Soap=[1,7,2,50,50,50,50,1];Winterblush=[0,50,50,50,50,50,50,0];Petal=[0,50,50,50,50,50,50,0]
		2: Soap=[0,50,50,50,50,50,50,0];Winterblush=[0,50,50,50,50,50,50,0];Petal=[0,50,50,50,50,50,50,0]
		3: Soap=[1,50,50,15,8,50,50,1];Winterblush=[1,8,14,50,50,50,50,0];Petal=[1,50,50,8,1,15,24,0]
	fill_rect(room_matrix,0,0,cols,rows,999)
	fill_rect(special_matrix,0,0,cols,rows,0)
	fill_rect(hurt_matrix,0,0,cols,rows,0)
	match n:
		1:
			cols = 17
			rows = 14
		2:
			cols = 17
			rows = 15
		3:
			cols = 30
			rows = 31
	await get_tree().create_timer(3).timeout
	loading = false

func _ready():
	for a in range(64):
		var c := []
		var r:=[]
		var k:=[]
		for b in range(64):
			c.append(0)
			k.append(0)
			r.append(999)
		room_matrix.append(r)
		special_matrix.append(c)
		hurt_matrix.append(k)

func fill_rect(m, a, b, c, d, v):
	for f in range(a, c + 1):
		for g in range(b, d + 1):
			m[f][g] = v

func _process(_delta: float) -> void:
	mini_delay = (0.15 * m1 * m2 * m3)
	if hunger < 20:
		m1 = 1.3
	else:
		m1= 1
	if water < 20:
		m2 = 1.3
	else:
		m2 = 1
	if sleep < 20:
		m3 = 1.3
	else:
		m3 = 1
	pass
