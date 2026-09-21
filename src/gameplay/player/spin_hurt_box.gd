class_name SpinHurtBox extends Area3D

@onready var shape_cast_3d: ShapeCast3D = %ShapeCast3D
@onready var kart_sphere: Kart_Sphere = %Kart_Sphere
var parent : Player
var spinIntangiblility := false

func _ready() -> void:
	parent = self.get_parent().get_parent()

func _on_area_entered(area: Area3D) -> void:
	if area is SpinHitbox:
		var spinhitbox : SpinHitbox = area
		if spinhitbox.hitbox_active and spinhitbox.parent != parent:
			if !spinIntangiblility:
				print("hit")
				call_knockback(spinhitbox.kart_sphere.kartCharacter.knockback)
				call_spin_hit_slowdown(spinhitbox.drift_stage, spinhitbox.kart_sphere.kartCharacter.weight)
				spinhitbox.call_spin_boost()

func call_knockback(opposing_knockback : float) -> void:
	shape_cast_3d.force_shapecast_update()
	if shape_cast_3d.is_colliding():
		print(to_local(shape_cast_3d.get_collision_point(0)))
		for i in shape_cast_3d.get_collision_count():
			var collision_point := to_local(shape_cast_3d.get_collision_point(i))
			kart_sphere.apply_clash_force(-collision_point, kart_sphere.knockback + (kart_sphere.kartCharacter.knockback - opposing_knockback)) 

func call_spin_hit_slowdown(drift_stage : int, opposing_weight : float) -> void:
	if drift_stage < 0:
		drift_stage = 0
	kart_sphere.spin_cooldown_timer = kart_sphere.spin_cooldown
	kart_sphere.apply_slowdown_force(kart_sphere.spin_hit_slowdown_amounts[drift_stage] + (kart_sphere.kartCharacter.weight - opposing_weight))
	kart_sphere.remove_drift_charge()
	
func call_slowdown() -> void:
	kart_sphere.apply_slowdown_force(0.5)

func call_stop() -> void:
	kart_sphere.apply_shortcut_stop_force()

func apply_boost_panel_boost(boost_speed_multiplier : float, boost_time_multiplier : float) -> void: ## Applies speed boost and from boost panel
	kart_sphere.set_boost(boost_speed_multiplier, boost_time_multiplier)
	if kart_sphere.drift_stage >= 3:
		kart_sphere.boost_panels_drifted_over += 1

func apply_trailing():
	pass
	# When in the opponents trail, the player kart will use a trail speed stat

#called by kartsphere
func setIntangiblility(state : bool) -> void:
	spinIntangiblility = state
