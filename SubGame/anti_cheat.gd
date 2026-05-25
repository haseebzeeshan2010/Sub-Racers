extends Area3D

@export var force_direction: Vector3 = Vector3.FORWARD
@export var force_strength: float = 5.0

var bodies: Array[RigidBody3D] = []

func _physics_process(delta: float) -> void:
	var dir := force_direction.normalized()
	for b in bodies:
		b.apply_force(dir * force_strength)


func _on_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		print("player in anticheat")
		bodies.append(body)
	pass # Replace with function body.


func _on_body_exited(body: Node3D) -> void:
	if body is RigidBody3D:
		print("player out of anticheat")
		bodies.erase(body)
	pass # Replace with function body.
