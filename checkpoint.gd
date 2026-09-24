extends Area3D

@onready var LapLogic: Node = $"../.."

# Does funny thing when a checkpoint is crossed
func _on_body_entered(body: Node3D) -> void:
	if body is Kart_Sphere: 
		body.add_checkpoint(get_instance_id())
	
func _ready() -> void:
	#send lap_logic.gd each instance ID
	LapLogic.log_checkpoints(get_instance_id())
