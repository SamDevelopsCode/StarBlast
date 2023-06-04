extends Node

var menu_music = preload("res://music/menu_music.mp3")
var level_1_music = preload("res://music/level_1_music.mp3")
var level_2_music = preload("res://music/level_2_music.mp3")
var level_3_music = preload("res://music/level_3_music.mp3")

func play_music(music):
	$Music.stream = music
	$Music.play()





