extends Node3D

@export var target: Node3D        # Assign your target node in the editor
@export var move_speed: float = 5 # Higher = faster movement
@export var rotate_speed: float = 5 # Higher = faster turning

func _ready() -> void:
	global_position = target.global_position

func _physics_process(delta: float) -> void:
	if target == null:
		return

	_smooth_move(delta)
	_smooth_look(delta)


func _smooth_move(delta: float) -> void:
	var current_pos := global_position
	var target_pos := target.global_position

	# Smoothly interpolate toward the target
	global_position = current_pos.lerp(target_pos, delta * move_speed)


func _smooth_look(delta: float) -> void:
	var direction := (target.global_position - global_position).normalized()

	if direction.length() < 0.001:
		return

	# Current and target rotations as quaternions
	var current_rot := global_transform.basis.get_rotation_quaternion()
	var target_rot := Basis.looking_at(direction, Vector3.UP).get_rotation_quaternion()

	# Smoothly rotate toward the target
	var smooth_rot := current_rot.slerp(target_rot, delta * rotate_speed)
	global_transform.basis = Basis(smooth_rot)
