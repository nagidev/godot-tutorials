extends Node

var state := {
	"health": 100,
	"key": 0
}

func has_value(key):
	return state.has(key)


func get_value(key):
	if state.has(key):
		return state[key]
	
	printerr("Key not present in state: ", key)


func set_value(key, value):
	state[key] = value
