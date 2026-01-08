extends Area2D
var lone = preload("res://images/prl1.png")
var ltwo = preload("res://images/prl2.png")
var cone = preload("res://images/prc1.png")
var ctwo = preload("res://images/prc2.png")
var wone = preload("res://images/prw1.png")
var wtwo = preload("res://images/prw2.png")
var can_move := true
var moving := false
var isplayer := false
var isbox := false
var isgoal := true
var active := false
var hasbeenactive := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Ray.is_colliding() and $Ray.get_collider().isbox:
		$but.texture = $but.two
		for node in get_tree().get_nodes_in_group("brl"+self.name):
			node.texture = ltwo
		for node in get_tree().get_nodes_in_group("brc"+self.name):
			node.texture = ctwo
		for node in get_tree().get_nodes_in_group("w"+self.name):
			node.texture = wtwo
			Global.room_matrix[(int(node.position.x+self.position.x) - (int(node.position.x+self.position.x) % 36)) / 36][int((node.position.y+self.position.y) - (int(node.position.y+self.position.y) % 36)) / 36] = 0
		active = true
	else:
		$but.texture = $but.one
		for node in get_tree().get_nodes_in_group("brl"+self.name):
			node.texture = lone
		for node in get_tree().get_nodes_in_group("brc"+self.name):
			node.texture = cone
		for node in get_tree().get_nodes_in_group("w"+self.name):
					node.texture = wone
					Global.room_matrix[(int(node.position.x+self.position.x) - (int(node.position.x+self.position.x) % 36)) / 36][int((node.position.y+self.position.y) - (int(node.position.y+self.position.y) % 36)) / 36] = 999
		active = false
	if active:
		hasbeenactive = true
	else:
		hasbeenactive = false

	pass
