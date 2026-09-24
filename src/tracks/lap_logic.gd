extends Node

@onready var checkpoints: Node = $Checkpoints


var check_list: Array[int]
# Calls the complete_lap() function in kart_rigidbody_sphere when StartLine is collided with
func _on_start_line_body_entered(body: Node3D) -> void:
	if body is Kart_Sphere:
		body.complete_lap()

# Debug function, prints instance id of each checkpoint in order
func print_checks() -> void:
	var count: int
	for id in check_list:
		count += 1
		print("LapLogic: check #" + str(count) + " " + str(id))

func log_checkpoints(check_id) -> void:
	check_list.append(check_id)
