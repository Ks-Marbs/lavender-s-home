extends Area2D
var one = preload("res://images/goal1.png")
var two = preload("res://images/goal2.png")
var can_move := true
var moving := false
var isplayer := false
var isbox := false
var isgoal := true
var active := false
var hasbeenactive := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(Global.full_delay).timeout
	Global.goals +=1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Ray.is_colliding() and $Ray.get_collider().isbox and $Ray.get_collider().position == self.position:
		$Sprite2d.texture = two
		active = true
	else:
		$Sprite2d.texture = one
		active = false
	if active and not hasbeenactive:
		Global.fgoals +=1
	if not active and hasbeenactive:
		Global.fgoals -= 1
	if active:
		hasbeenactive = true
	else:
		hasbeenactive = false

	pass
