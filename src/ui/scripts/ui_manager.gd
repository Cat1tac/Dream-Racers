extends Node

var current_state: State = State.NONE
@onready var main_menu: UIState = %MainMenu
@onready var character_select: UIState = %CharacterSelect
@onready var track_select: UIState = %TrackSelect

## defined states that the UI can be in
enum State {
	NONE, 
	MAIN_MENU, 
	CHAR_SELECT, 
	TRACK_SELECT,
	}

func _ready() -> void:
	if main_menu.visible:
		current_state = State.MAIN_MENU

#region forward transitions
func _on_race_button_pressed() -> void:
	current_state = State.CHAR_SELECT
	main_menu.transition_to_state(character_select)

#endregion

#region back transitions
func _on_char_back_button_pressed() -> void:
	current_state = State.MAIN_MENU
	character_select.transition_to_state(main_menu)

func _on_track_back_button_pressed() -> void:
	current_state = State.CHAR_SELECT
	track_select.transition_to_state(character_select)
	
#endregion
