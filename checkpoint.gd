extends Area3D

# Does funny thing when a checkpoint is crossed
func _on_body_entered(body: Node3D) -> void:
	if body is Kart_Sphere: 
		body.add_checkpoint(get_instance_id())
	
