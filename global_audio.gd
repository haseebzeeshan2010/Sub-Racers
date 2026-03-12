extends Node

# Change music instantly
func change_music(path: String):
	%IntroMusic.stream = load(path)
	%IntroMusic.play()

# Smooth crossfade between tracks
func change_music_smooth(path: String, fade_time := 1.0):
	var tween = create_tween()

	# Fade out current music
	tween.tween_property(%IntroMusic, "volume_db", -40, fade_time)

	# After fade-out, switch the stream and restart
	tween.tween_callback(func():
		%IntroMusic.stream = load(path)
		%IntroMusic.play()
	)

	# Fade back in
	tween.tween_property(%IntroMusic, "volume_db", 0, fade_time)

# Play the intro music (first track)
func play_intro():
	change_music("res://SubRacersIntroStream.tres")

# When the intro track finishes, switch to the loop
func _on_intro_music_finished():
	change_music("res://SubRacersIntroLoopStream.tres")

# Level music (called when gameplay starts)
func levelmusic():
	change_music_smooth("res://SubRacersRaceThemeLoopStream.tres")
	
func selection_music():
	change_music_smooth("res://SubRacersIntroLoopStream.tres")

func button_press_fx():
	%ButtonFX.play()
