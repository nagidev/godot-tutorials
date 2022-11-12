extends Spatial

signal rotation_started
signal rotation_ended

onready var ice_ray = $IceRay
onready var indicator = $Indicator
onready var animation_player = $AnimationPlayer
onready var block_scene = load("res://Ice Tutorial/Ice Power/Block.tscn")

var active = false
var angle = 0
var last = null

func _process(_delta):
	if Input.is_action_just_pressed("ice_activate"):
		if not active:
			active = true
		else:
			angle = stepify(wrapi(angle + 90, 0, 360), 90)
		animation_player.play("RESET")
		yield(animation_player, "animation_finished")
		animation_player.play("glow")
	elif Input.is_action_just_pressed("ui_cancel"):
		animation_player.play("fade")
		yield(animation_player, "animation_finished")
		active = false
		angle = 0
	
	if ice_ray.is_colliding() and active:
		var collision_normal = ice_ray.get_collision_normal()
		
		if collision_normal.dot(Vector3.UP) > 0.5:
			var offset_dist = ice_ray.get_collision_point().distance_to(global_transform.origin)
			indicator.translation.z = -offset_dist
			indicator.global_transform.basis = owner.global_transform.basis.rotated(Vector3.UP, deg2rad(angle))
			indicator.show()
			
			if Input.is_action_just_pressed("mouse_left"):
				create_block()
			return
	
	indicator.hide()


func _input(event):
	# inform player to stop look_rot
	if Input.is_action_just_pressed("mouse_right"):
		emit_signal("rotation_started")
	elif Input.is_action_just_released("mouse_right"):
		emit_signal("rotation_ended")
	
	if active and event is InputEventMouseMotion and Input.is_action_pressed("mouse_right"):
		angle = wrapi(angle + event.relative.x, 0, 360)


func create_block():
	var new_block = block_scene.instance()
	get_tree().current_scene.add_child(new_block)
	new_block.global_transform.origin = indicator.global_transform.origin
	new_block.global_transform.basis = indicator.global_transform.basis
	active = false
	angle = 0
	
	if last:
		last.queue_free()
	last = new_block
