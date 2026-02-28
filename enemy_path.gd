extends Path3D

@export var reversepath : bool
@export var debugbox : bool
var collision = false
var targetpoint : Vector3

func _ready() -> void:
	if debugbox:
		%DebugBox.visible = true

func _process(delta: float) -> void:
	if collision == true:
		if reversepath:
			%EnemyPointer.progress = %EnemyPointer.progress-1
		else:
			%EnemyPointer.progress = %EnemyPointer.progress+1
		targetpoint = %EnemyPointer.global_position
	
	
func _on_area_3d_body_entered(body: Node3D) -> void:
	collision = true
	
	


func _on_area_3d_body_exited(body: Node3D) -> void:
	collision = false
