extends Interactable


func _on_interacted(_body):
	GameState.set_value("key", GameState.get_value("key") + 1)
	queue_free()
