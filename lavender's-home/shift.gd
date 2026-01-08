extends Sprite2D
var one = preload("res://images/shift1.png")
var two = preload("res://images/shift2.png")
var three = preload("res://images/shift3.png")
var four = preload("res://images/shift4.png")
var xcell := (position.x - (int(position.x) % 36)) / 36
var ycell := (position.y - (int(position.y) % 36)) / 36

func wiggle():
	while 1==1:
		texture = one
		await get_tree().create_timer(Global.wiggle_delay).timeout
		texture = two
		await get_tree().create_timer(Global.wiggle_delay).timeout
		texture = three
		await get_tree().create_timer(Global.wiggle_delay).timeout
		texture = four
		await get_tree().create_timer(Global.wiggle_delay).timeout

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(Global.full_delay).timeout
	if rotation_degrees == 0 or rotation_degrees == 360 or rotation_degrees == -360:
		Global.special_matrix[xcell][ycell] = 2
	if rotation_degrees == 180 or rotation_degrees == -180:
		Global.special_matrix[xcell][ycell] = 3
	if rotation_degrees == -90 or rotation_degrees == 270:
		Global.special_matrix[xcell][ycell] = 4
	if rotation_degrees == 90 or rotation_degrees == -270:
		Global.special_matrix[xcell][ycell] = 5
	wiggle()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.level == 15:
		Global.room_matrix[xcell][ycell] = 0
	pass
