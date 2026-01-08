extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if DisplayServer.is_touchscreen_available():
		scale = Vector2.ONE
	else:
		scale = Vector2.ONE * 0.75
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.button_pressed:
		Global.toggle = true
	pass
