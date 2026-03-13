extends Control

var scene_to_change = ""

var tutorial_scene = preload("res://CarGame/Tutorial.tscn")
var level1_scene = preload("res://CarGame/Level1.tscn")
var level2_scene = preload("res://CarGame/Level2.tscn")
var start_scene = preload("res://CarGame/StartScene.tscn")

var scenes = {
	"Tutorial": tutorial_scene,
	"Level1": level1_scene,
	"Level2": level2_scene,
	"StartScene": start_scene
}

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_start_tutorial_button_pressed() -> void:
	print("start tutorial")
	%TransitionPlayer.play("StartSceneExit_LevelChanger")
	scene_to_change = "Tutorial"
	get_node("/root/GlobalAudio").button_press_fx()

func _on_start_level_button_pressed() -> void:
	print("start level 1: Murky Waters")
	%TransitionPlayer.play("StartSceneExit_LevelChanger")
	scene_to_change = "Level1"
	get_node("/root/GlobalAudio").button_press_fx()

func _on_start_level2_button_pressed() -> void:
	print("start level 2: Thermal Trench")
	%TransitionPlayer.play("StartSceneExit_LevelChanger")
	scene_to_change = "Level2"
	get_node("/root/GlobalAudio").button_press_fx()

func _on_title_screen_button_pressed() -> void:
	scene_to_change = "StartScene"
	%TransitionPlayer.play("StartSceneExit_LevelChanger_2")
	print("start title screen")
	get_node("/root/GlobalAudio").button_press_fx()

func _on_transition_player_animation_finished(anim_name: StringName) -> void:
	if scene_to_change in scenes:
		get_tree().change_scene_to_packed(scenes[scene_to_change])

func _on_transition_player_animation_started(anim_name: StringName) -> void:
	pass
