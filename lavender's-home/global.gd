extends Node
#just adding this so i can make a repoaaaaaaaaaaaaaa
var took_stairs := false
var talking := false
var mini_delay := 0.15
var full_delay := 0
var health := 100
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
var soap := 1
var clear = false
var level = 1
var x := 0
var y := 0
var loading := false
var save:=[[0,0,0,0,1],\
[1,50,40,30,1],[2,78,68,58,0],[3,73,63,53,0],[4,105,95,85,0],[5,65,55,45,0],\
[6,80,70,60,0],[7,86,76,66,0],[8,108,98,88,0],[9,48,38,28,0],[10,66,56,46,1],\
[11,62,52,42,0],[12,118,108,98,0],[13,109,99,89,0],[14,115,105,95,0],[15,730,700,670,0]]


func get_matrix(a,b,mat):
	if a <= cols and b <= rows and a >= 0 and b >= 0:
		return mat[a][b]
	else:
		return 999


func prepare(n):
	loading = true
	fgoals = 0
	goals = 0
	fill_rect(room_matrix,0,0,cols,rows,999)
	fill_rect(special_matrix,0,0,cols,rows,0)
	fill_rect(hurt_matrix,0,0,cols,rows,0)
	match n:
		1:
			cols = 17
			rows = 14
		2:
			cols = 17
			rows = 14
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
	pass
