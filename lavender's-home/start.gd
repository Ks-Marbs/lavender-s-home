extends Node2D
var creds := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $start.button_pressed:
		get_tree().change_scene_to_file("res://level_1.tscn")
	if $settings.button_pressed:
		Global.toggle = true
	if $credits.button_pressed:
		creds = true
	if Global.toggle or creds:
		$Title.visible = false
		$start.visible = false
		$settings.visible = false
		$credits.visible = false
	else:
		$Title.visible = true
		$start.visible = true
		$settings.visible = true
		$credits.visible = true
	if creds:
		if $cred.position.y < -5061:
			await get_tree().create_timer(Global.wiggle_delay*6).timeout
			creds = false
			$cred.position.y = 650
		else:
			$cred.position.y -= 6
