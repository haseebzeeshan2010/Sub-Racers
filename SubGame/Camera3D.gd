extends Camera3D

@export var follow_speed = 12.0
@export var lookat_speed = 20.0

@export var target: Node3D
@export var lookattarget: Node3D

func _physics_process(delta):
	if not lookattarget or not target:
		return 
	global_position = lerp(global_position, target.global_position, delta * follow_speed) # smooth out camera
	# look_at(lookattarget.global_position, Vector3.UP)
	#set_global_transform(get_parent().get_global_transform())
	var target_transform = global_transform.looking_at(lookattarget.global_position, Vector3.UP)
	global_transform = global_transform.interpolate_with(target_transform, delta * lookat_speed)
