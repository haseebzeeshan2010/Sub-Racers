extends Control

func _on_button_pressed() -> void:
	%TransitionPlayer.play("StartSceneExit")

func _on_transition_player_animation_finished(_anim_name: StringName) -> void:
	if _anim_name == "StartSceneExit":
		get_tree().change_scene_to_file("res://CarGame/LevelChanger.tscn")


func _on_transition_player_animation_started(anim_name: StringName) -> void:
	#if anim_name == "StartSceneEntrance":
		#get_node("/root/GlobalAudio").selection_music()
	pass # Replace with function body.
