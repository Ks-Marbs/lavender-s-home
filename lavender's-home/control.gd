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
	if $down.button_pressed:
		if not Input.is_action_pressed("down"):
			Input.action_press("down")
	else:
		if Input.is_action_pressed("down"):
			Input.action_release("down")
	if $up.button_pressed:
		if not Input.is_action_pressed("up"):
			Input.action_press("up")
	else:
		if Input.is_action_pressed("up"):
			Input.action_release("up")
	if $lef.button_pressed:
		if not Input.is_action_pressed("left"):
			Input.action_press("left")
	else:
		if Input.is_action_pressed("left"):
			Input.action_release("left")
	if $righ.button_pressed:
		if not Input.is_action_pressed("right"):
			Input.action_press("right")
	else:
		if Input.is_action_pressed("right"):
			Input.action_release("right")
	if $interact.button_pressed:
		if not Input.is_action_pressed("in"):
			Input.action_press("in")
	else:
		if Input.is_action_pressed("in"):
			Input.action_release("in")
	pass
