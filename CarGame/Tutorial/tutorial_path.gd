extends Path3D

@export var reversepath: bool
@export var debugbox: bool

var collision := false

func _ready() -> void:
	%TutorialFollow.visible = debugbox

func _process(delta: float) -> void:
	# Update targetpoint when moving along the path
	
	if collision:
		if reversepath:
			%TutorialPointer.progress -= 1
		else:
			%TutorialPointer.progress += 1

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body is RigidBody3D:
		return
	collision = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if not body is RigidBody3D:
		return
	collision = false
