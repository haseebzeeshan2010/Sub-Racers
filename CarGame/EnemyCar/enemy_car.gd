extends RigidBody3D

@export var impulse_strength = 1500
@export var torque_strength = 100
@export var enemytrack: Path3D
var race_active = false

func _physics_process(delta):
	%EngineAudio.volume_db = (2*linear_velocity.length())-40
	#print(linear_velocity.length())
	
	if not race_active:
		return

	#Get Relative Velocities(Useful for Drifting Code)
	var vel: Vector3 = linear_velocity
	var basis := global_transform.basis
	var relative_velocity = Vector3(
		vel.dot(basis.x), # right
		vel.dot(basis.y), # up
		vel.dot(-basis.z) # forward
	)
	

	# Create a target position at the same y-level as the car
	var target_position = Vector3(enemytrack.targetpoint.x, global_transform.origin.y, enemytrack.targetpoint.z)
	
	# Calculate direction to target
	var target_direction = (target_position - global_transform.origin)
	target_direction.y = 0.0
	target_direction = target_direction.normalized()
	
	# Get car's current forward direction
	var current_forward = - global_transform.basis.z
	
	# Calculate angle difference
	var angle_to_target = current_forward.signed_angle_to(target_direction, Vector3.UP)
	
	# --- TURNING ---
	# Apply torque to turn towards the mouse position
	# Scale torque based on angle difference for smoother turning
	if abs(angle_to_target) > 0.05:
		var torque_direction = sign(angle_to_target)
		var torque_magnitude = clamp(abs(angle_to_target) * 2.0, 0.0, 1.0)
		apply_torque(Vector3.UP * torque_direction * torque_strength * torque_magnitude)
	
	# --- ACCELERATION ---
	# Apply forward force towards the mouse position
	if global_transform.origin.distance_to(target_position) > 1.0:
		apply_central_force(-global_transform.basis.z * impulse_strength * delta)
	
	linear_damp = 2.0
	angular_damp = 3.0
	
	# SKID CODE
	
	#debug code
	#print(relative_velocity.z, " ", relative_velocity.x)
	
	if abs(relative_velocity.x) > 9:
		# Activate skid marks
		if has_node("%Trail"):
			%Trail.skid()
		if has_node("%Trail2"):
			%Trail2.skid()
	else:
		 #Stop skidding
		if has_node("%Trail"):
			%Trail.stop_skid()
		if has_node("%Trail2"):
			%Trail2.stop_skid()
			
	# VAN TILT CODE
	
	%Submarine.rotation = Vector3(lerp(%Submarine.rotation.x, angular_velocity.y/2, delta), 1.570796*2, 0)


func _on_start_signal_race_started() -> void:
	race_active = true
	pass # Replace with function body.


func _on_round_round_finished(player_won: bool) -> void:
	race_active = false
	pass # Replace with function body.
