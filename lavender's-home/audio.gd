extends Node2D
var a = 0
var volume_linear:=1

func _ready() -> void:
	$masterloop.play(a)

func _physics_process(delta: float) -> void:
	$masterloop.volume_linear = volume_linear
	if $masterloop.get_playback_position() > a+8:
		$masterloop.play(a)
