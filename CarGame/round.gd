extends Area3D

signal round_finished(player_won: bool)

var nobodies = 0

func _ready() -> void:
	pass
var roundcontinues = true

func _process(delta: float) -> void:
	pass
var initialtimer = 11

func _on_body_entered(body: Node3D) -> void:
	if not body is RigidBody3D:
		return
	print("BODY ENTERED")
	nobodies += 1
	if nobodies >= 1:
		print(body.name)
		var player_won = body.name == "PlayerCar"
		emit_signal("round_finished", player_won)
		

func _on_round_finished(player_won: bool) -> void:
	%GameOver.play("GameOver")
	if roundcontinues:
		if player_won:
			%Label2.text = "You came 1st"
			roundcontinues = false
		else:
			%Label2.text = "You came 2nd"
			roundcontinues = false
		monitoring = false
	
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	initialtimer -= 1
	%TimerLabel.text = str(initialtimer)
	pass # Replace with function body.


func _on_start_signal_race_started() -> void:
	%TimerLabel.visible = false
	pass # Replace with function body.
