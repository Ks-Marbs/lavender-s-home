extends Node2D
var creds := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $play.button_pressed:
		get_tree().change_scene_to_file("res://level_1.tscn")
	if $settings.button_pressed:
		Global.toggle = true
	if $credits.button_pressed:
		creds = true
	if creds:
		$ColorRect.visible = 1
		if $cred.position.y < -3400:
			creds = false
			$cred.position.y = 500
		else:
			$cred.position.y -= 6
	else: $ColorRect.visible = 0
