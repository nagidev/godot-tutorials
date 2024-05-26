extends Interactable

@export var item_id : String

var playback: AnimationNodeStateMachinePlayback
var opened := false


func _ready():
	playback = $AnimationTree.get("parameters/playback")


func open_chest():
	playback.travel("ChestOpen")
	GameState.set_value(item_id, 1)
	opened = true
	enabled = false


func _on_interacted(_body):
	if not opened and GameState.get_value("key") > 0:
		GameState.set_value("key", GameState.get_value("key") - 1)
		open_chest()
