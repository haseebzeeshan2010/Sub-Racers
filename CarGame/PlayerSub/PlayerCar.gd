extends RigidBody3D

@export var impulse_strength = 1500
@export var torque_strength = 100
@export var use_keyboard_steering = false
@export var max_health = 11

var mouse_position_3d = Vector3.ZERO
var has_valid_mouse_position = false
var race_active = false

func _physics_process(delta):
	%EngineAudio.volume_db = (2*linear_velocity.length())-40
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
	
	
	# Cast a ray from the camera to get the 3D mouse position
	var camera = get_viewport().get_camera_3d()
	has_valid_mouse_position = false

	if camera:
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_direction = camera.project_ray_normal(mouse_pos)
		
		# Define a plane at the car's Y position (or ground level)
		var plane_y = global_transform.origin.y # Use sub's height
		var plane_normal = Vector3.UP
		
		# Calculate intersection with the horizontal plane
		# Using plane intersection formula: t = (plane_y - ray_origin.y) / ray_direction.y
		if abs(ray_direction.y) > 0.001: # Avoid division by zero
			var t = (plane_y - ray_origin.y) / ray_direction.y
			if t > 0: # Only if intersection is in front of camera
				mouse_position_3d = ray_origin + ray_direction * t
				has_valid_mouse_position = true
		
		# Fallback: If horizontal plane intersection failed, use a vertical plane ahead of the car
		if not has_valid_mouse_position:
			# Create a vertical plane 50 units ahead of the sub
			var plane_distance = 50.0
			var plane_point = global_transform.origin - global_transform.basis.z * plane_distance
			var plane_forward = - global_transform.basis.z
			
			# Calculate intersection with vertical plane: t = dot(plane_point - ray_origin, plane_normal) / dot(ray_direction, plane_normal)
			var denominator = ray_direction.dot(plane_forward)
			if abs(denominator) > 0.001:
				var t_vertical = (plane_point - ray_origin).dot(plane_forward) / denominator
				if t_vertical > 0:
					mouse_position_3d = ray_origin + ray_direction * t_vertical
					has_valid_mouse_position = true
		
		# Check if the target is behind the sub and clamp to minimum distance ahead
		if has_valid_mouse_position:
			var to_target = mouse_position_3d - global_transform.origin
			var forward = - global_transform.basis.z
			var forward_distance = to_target.dot(forward)
			
			# If target is behind the sub (negative forward distance), clamp to minimum distance ahead
			var min_forward_distance = 10.0
			if forward_distance < min_forward_distance:
				# Project the target onto a circle at the minimum distance
				var lateral_offset = to_target - (forward * forward_distance)
				mouse_position_3d = global_transform.origin + forward * min_forward_distance + lateral_offset

	if use_keyboard_steering:
		# --- KEYBOARD STEERING MODE (arrow keys) ---
		var turning = Input.get_axis("ui_right", "ui_left") # left = positive, right = negative
		var accelerating = Input.is_action_pressed("ui_up")

		if turning != 0.0:
			apply_torque(Vector3.UP * turning * torque_strength / 4)

		var reversing = Input.is_action_pressed("ui_down")

		if accelerating:
			apply_central_force(-global_transform.basis.z * impulse_strength * delta)
			linear_damp = 2.0
			angular_damp = 3.0
		elif reversing:
			apply_central_force(global_transform.basis.z * impulse_strength * 0.4 * delta)
			linear_damp = 2.0
			angular_damp = 3.0
		else:
			linear_damp = 1.0
			angular_damp = 8.0
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and has_valid_mouse_position:
		# Create a target position at the same y-level as the car
		var target_position = Vector3(mouse_position_3d.x, global_transform.origin.y, mouse_position_3d.z)
		
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
	else:
		# Higher damping when not accelerating
		linear_damp = 3
		angular_damp = 8.0

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
			
	# SUB TILT CODE
	
	%Submarine.rotation = Vector3(0, 1.570796, -lerp(%Submarine.rotation.x, angular_velocity.y * 10, delta))





#RACE START AND FINISH CODE
func _on_start_signal_race_started() -> void:
	race_active = true
	pass # Replace with function body.


func _on_round_round_finished(player_won: bool) -> void:
	race_active = false
	pass # Replace with function body.

#DAMAGE CODE
func _on_damage_area_area_entered(area: Area3D) -> void:
	max_health -= 4
	max_health = clamp(max_health,0,11)
	%DamageFlashPlayer.play("DamageFlash")
	%DamageFlashPlayer.seek(0.0, true)
	%HealthBar.update_bar(max_health)
	
	if max_health == 0:
		race_active = false
		axis_lock_linear_y = false
		# Low damping for good drag on
		linear_damp = 0.5
		angular_damp = 5
		%LavaOver.visible = true
		%NormalOver.visible = false
		%GameOver.play("GameOver")
	pass # Replace with function body.
