extends Node


@onready var checkpoints: Node = $Checkpoints

# Calls the complete_lap() function in kart_rigidbody_sphere when StartLine is collided with
func _on_start_line_body_entered(body: Node3D) -> void:
	if body is Kart_Sphere:
		body.complete_lap()
