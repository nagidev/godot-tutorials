extends CharacterBody3D

var time = 0.0

func _physics_process(delta):
	time += delta
	position.x = sin(time) * 8
	rotation.y += delta
