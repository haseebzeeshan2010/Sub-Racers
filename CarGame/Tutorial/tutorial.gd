extends Node3D

signal moved_once   # Signal that fires only once

var moved: bool = false
var has_emitted: bool = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	var turning := Input.get_axis("ui_right", "ui_left")
	var accelerating := Input.is_action_pressed("ui_up")

	# Detect movement
	if turning != 0.0 or accelerating and %PlayerCar.race_active:
		moved = true

	# Emit the signal ONCE when moved becomes true
	if moved and not has_emitted and %PlayerCar.race_active:
		has_emitted = true
		emit_signal("moved_once")


func _on_texture_button_pressed() -> void:
	%PlayerCar.race_active = true
	%Line1Player.play("Line1exit")
	%Line2Player.play("Line2")


func _on_moved_once() -> void:
	print("PLAYER MOVED")
	%TutorialPath.visible = true
	%Second_Third_Player.play("secondthirdanim")
	pass # Replace with function body.


func _on_round_round_finished(player_won: bool) -> void:
	%Line2Player.play("Line2Exit")
	pass # Replace with function body.
