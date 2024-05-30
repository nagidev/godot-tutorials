extends CollisionObject3D
class_name Interactable

signal interacted(body)

@export var enabled = true
@export var prompt_message = "Interact"
@export var prompt_action = "interact"


func get_prompt():
	if not enabled:
		return ""
	
	var key_name := ""
	for action in InputMap.action_get_events(prompt_action):
		if action is InputEventKey:
			key_name = action.as_text_physical_keycode()
			break
		elif action is InputEventMouseButton:
			key_name = action.as_text()
	return prompt_message + "\n[" + key_name + "]"


func interact(body):
	if not enabled:
		return
	
	interacted.emit(body)
