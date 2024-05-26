extends Node3D


@onready var path_follow = $Path3D/PathFollow3D

var target_offset := 0.0
var tween : Tween

func toggle(_body):
	target_offset = 1.0 if target_offset == 0.0 else 0.0
	
	if tween:
		tween.kill()
	
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(path_follow, "progress_ratio", target_offset, 4.0)
