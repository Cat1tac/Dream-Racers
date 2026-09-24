class_name LocalLapLogic extends Area3D

var checks_needed : int = 5 # How many checkpoints are in the track (not counting StartLine)
var laps_done: int
var progress: Array
var check_order: Array

func complete_lap() -> void:
	if len(progress) == checks_needed:
		progress.clear()
		laps_done += 1
		print("LapLogic: lap #" + str(laps_done) + " completed!! yay!!")
	else:
		print("LapLogic: Player does not have the correct amount of progress")

func add_checkpoint(check_id: int) -> void:
	
	var _needed_check = check_order[progress.size()] # This is the value that we should be looking for
	
	print("Comparing recieved ID: " + str(check_id) + "to the required ID: " + str(_needed_check))
	if check_id == _needed_check:
		progress.append(check_id)
		print("LapLogic: Checkpoint ID: " + str(check_id) + " is a valid checkpoint!")
		print("LapLogic: Checkpoint #" + str(progress.size()) + " was crossed (id: " + str(check_id) + ")")
	else:
		print("LapLogic: Checkpoint ID: " + str(check_id) + " is not a valid checkpoint.")

func race_started() -> bool:
	if laps_done == 0 and len(progress) == 0: 
		return false
	else: 
		return true

func get_check_order(order: Array) -> void:
	print("LapLogic: kart is recieving order of checkpoints")
	check_order = order
