extends Interactable


func _on_interacted(_body):
	$AudioStreamPlayer3D.play()
