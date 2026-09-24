extends Node

#@onready var checkpoints: Node = $"../Checkpoints"
var checks_needed : int = 5 # How many checkpoints are in the track (not counting StartLine)

var laps_done: int

func _on_kart_sphere_lap_completed(progress: Array) -> void:
	if len(progress) == checks_needed:
		progress.clear()
		laps_done += 1
		print("LapLogic: lap #" + str(laps_done) + " completed!! yay!!")
	else:
		print("LapLogic: Player does not have the correct amount of progress")

func _on_kart_sphere_checkpoint_crossed(check_id: int, progress: Array) -> void:
	var _size = len(progress)
	print("LapLogic: Checkpoint #" + str(_size + 1) + " was crossed (id: " + str(check_id) + ")")
	if check_id not in progress:
		#if LapLogic.checklist[len(progress)] == check_id:
		progress.append(check_id)
		print("LapLogic: Checkpoint ID: " + str(check_id) + " is a valid checkpoint!")
