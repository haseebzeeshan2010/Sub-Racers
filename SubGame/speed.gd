extends Label

@export var use_mph = false
@onready var submarine = get_owner()



func _process(_delta: float) -> void:
	
	if submarine == null:
		return

	var speed_ms = submarine.linear_velocity.length()

	if use_mph:
		text = "%d mph" % roundi(speed_ms * 2.23694)
	else:
		text = "%d km/h" % roundi(speed_ms * 3.6)
