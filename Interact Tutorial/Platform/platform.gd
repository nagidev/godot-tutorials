extends Spatial

onready var path_follow = $Path/PathFollow

var target_offset = 0.0

func toggle(_body):
	if target_offset == 0.0:
		target_offset = 1.0
	else:
		target_offset = 0.0
	
	var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(path_follow, "unit_offset", target_offset, 2)
