extends Label

@export var use_mph = false


func _process(_delta: float) -> void:
	var car = %PlayerCar
	if car == null:
		return

	var speed_ms = car.linear_velocity.length()

	if use_mph:
		text = "%d mph" % roundi(speed_ms * 2.23694)
	else:
		text = "%d km/h" % roundi(speed_ms * 3.6)
