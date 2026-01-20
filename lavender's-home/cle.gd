extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match Global.level:
		1:
			$moves.text = "Going down the stairs"
		2:
			$moves.text = "Going up the stairs"
	if Global.took_stairs:
		visible = true
	else:
		visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.took_stairs:
		visible = true
	else:
		visible = false
