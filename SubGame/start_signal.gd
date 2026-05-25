extends Node
signal race_started

func _on_timer_timeout() -> void:
	race_started.emit()
	print("Signal Start")
	pass # Replace with function body.
