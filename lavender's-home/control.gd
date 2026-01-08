extends Control
var on:= false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if DisplayServer.is_touchscreen_available():
		visible = true
	else:
		visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $lef.button_pressed:
		Input.action_press("left")
		on = true
	if $righ.button_pressed:
		Input.action_press("right")
		on = true
	if $up.button_pressed:
		Input.action_press("up")
		on = true
	if $down.button_pressed:
		Input.action_press("down")
		on = true
	if on and not $lef.button_pressed:
		Input.action_release("left")
	if  on and not $righ.button_pressed:
		Input.action_release("right")
	if  on and not $up.button_pressed:
		Input.action_release("up")
	if  on and not $down.button_pressed:
		Input.action_release("down")
	pass
