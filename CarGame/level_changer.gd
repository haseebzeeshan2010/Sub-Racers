extends Control

var scene_to_change = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_tutorial_button_pressed() -> void:
	print("start tutorial")
	%TransitionPlayer.play("StartSceneExit_LevelChanger")
	scene_to_change = "Tutorial"
	pass # Replace with function body.


func _on_start_level_button_pressed() -> void:
	print("start level 1: Murky Waters")
	%TransitionPlayer.play("StartSceneExit_LevelChanger")
	scene_to_change = "Level1"
	pass # Replace with function body.


func _on_start_level2_button_pressed() -> void:
	print("start level 2: Thermal Trench")
	%TransitionPlayer.play("StartSceneExit_LevelChanger")
	scene_to_change = "Level2"
	pass # Replace with function body.


func _on_title_screen_button_pressed() -> void:
	scene_to_change = "StartScene"
	%TransitionPlayer.play("StartSceneExit_LevelChanger")
	print("start title screen")
	pass # Replace with function body.


func _on_transition_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://CarGame/"+scene_to_change+".tscn")
	pass # Replace with function body.
