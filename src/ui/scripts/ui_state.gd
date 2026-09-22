@abstract
class_name UIState
extends Control
## an abstract class for UI states with functions to transition between
## and signal transitions.

signal transition_finished

func _ready() -> void:
	pass

func transition_to_state(newState: UIState) -> void:
	hide()
	newState.show()
