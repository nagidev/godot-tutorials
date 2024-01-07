extends CharacterBody3D

var time = 0.0

func _physics_process(delta):
	time += delta
	position.y = 20 + sin(time) * 8
