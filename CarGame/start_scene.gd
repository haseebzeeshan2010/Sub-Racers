extends Control

func _ready() -> void:
	%CreditsCover.mouse_filter = MOUSE_FILTER_IGNORE

func _on_button_pressed() -> void:
	%TransitionPlayer.play("StartSceneExit")
	get_node("/root/GlobalAudio").button_press_fx()

func _on_transition_player_animation_finished(_anim_name: StringName) -> void:
	if _anim_name == "StartSceneExit":
		get_tree().change_scene_to_file("res://CarGame/LevelChanger.tscn")


func _on_transition_player_animation_started(anim_name: StringName) -> void:
	#if anim_name == "StartSceneEntrance":
		#get_node("/root/GlobalAudio").selection_music()
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	%GameOver.play("CreditShow")
	get_node("/root/GlobalAudio").button_press_fx()
	pass # Replace with function body.


func _on_texture_button_pressed() -> void:
	%GameOver.play("CreditHide")
	get_node("/root/GlobalAudio").button_press_fx()
	pass # Replace with function body.
