extends Area3D

@export_file("*.tscn") var to_scene : String


func _on_body_entered(body):
	if body is Player:
		# call deferred because of the changes introduced in Godot 4.2
		get_tree().change_scene_to_file.bind(to_scene).call_deferred()
