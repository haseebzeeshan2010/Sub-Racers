extends Label

@export var use_mph = false
@onready var car = get_owner()



func _process(_delta: float) -> void:
	
	if car == null:
		return

	var speed_ms = car.linear_velocity.length()

	if use_mph:
		text = "%d mph" % roundi(speed_ms * 2.23694)
	else:
		text = "%d km/h" % roundi(speed_ms * 3.6)
