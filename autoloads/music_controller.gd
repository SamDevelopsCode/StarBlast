extends Node

var menu_music = preload("res://music/menu_music.mp3")
var level_1_music = preload("res://music/level_1_music.mp3")
var level_2_music = preload("res://music/level_2_music.mp3")
var level_3_music = preload("res://music/level_3_music.mp3")

@onready var music: AudioStreamPlayer = $Music

func fade_music_in(music_name: String):
	var fade_out = get_tree().create_tween()
	fade_out.tween_property(music, "volume_db", -50, 1.0)
	await get_tree().create_timer(1.0).timeout

	match music_name:
		"menu":
			music.stream = menu_music
			music.volume_db = -50
			music.play()
			var fade_in = get_tree().create_tween()
			fade_in.tween_property(music, "volume_db", -5, 2)
		"level_1_music":
			music.stream = level_1_music
			music.volume_db = -60
			music.play()
			var fade_in = get_tree().create_tween()
			fade_in.tween_property(music, "volume_db", -5, 2)
		"level_2_music":
			music.stream = level_2_music
			music.volume_db = -60
			music.play()
			var fade_in = get_tree().create_tween()
			fade_in.tween_property(music, "volume_db", -5, 2)
		"level_3_music":
			music.stream = level_3_music
			music.volume_db = -60
			music.play()
			var fade_in = get_tree().create_tween()
			fade_in.tween_property(music, "volume_db", -5, 2)
