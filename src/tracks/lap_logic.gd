extends Node

@onready var checkpoints: Node = $Checkpoints

var check_list: Array[int]

# Debug function, prints instance id of each checkpoint in order
func print_checks() -> void:
	var count: int
	for id in check_list:
		count += 1
		print("LapLogic: check #" + str(count) + " " + str(id))

func log_checkpoints(check_id) -> void:
	check_list.append(check_id)

func _on_start_line_area_entered(area: Area3D) -> void:
		if area is LocalLapLogic:
			area.complete_lap()
			if not area.race_started():
				area.get_check_order(check_list)
