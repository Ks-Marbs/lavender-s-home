extends Sprite2D
var t := ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(get_child_count()-1):
		get_child(i).get_child(0).text = get_child(i).name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$t.text = t

	if t == "XXXXXXX":
		texture =  load("res://images/boop.png")
		for i in range(get_child_count()-1):
			get_child(i).visible = 0
	pass
