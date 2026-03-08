extends Control

var next_scene := preload("res://CarGame/StartScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_intro_player_animation_started(anim_name: StringName) -> void:
	get_node("/root/GlobalAudio").play_intro()
	pass # Replace with function body.


func _on_intro_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_packed(next_scene)
