extends Control

func _on_button_pressed() -> void:
	%TransitionPlayer.play("StartSceneExit")

func _on_transition_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://CarGame/LevelChanger.tscn")
