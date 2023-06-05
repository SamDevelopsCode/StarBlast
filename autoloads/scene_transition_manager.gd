extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func fade_to_level_1():
	animation_player.play("fade_to_level_1")
	MusicController.fade_music_in("level_1_music")

func fade_to_level_2():
	animation_player.play("fade_to_level_2")
	MusicController.fade_music_in("level_1_music")
	
func fade_to_level_3():
	animation_player.play("fade_to_level_3")
	MusicController.fade_music_in("level_1_music")
	
func fade_to_choose_stage():
	animation_player.play("fade_to_choose_stage")	
	
func fade_to_menu():
	animation_player.play("fade_to_menu")
	
func change_level(level: int):
	match level:
		1:
			get_tree().change_scene_to_file("res://levels/level_1.tscn")
		2:
			get_tree().change_scene_to_file("res://levels/level_2.tscn")
		3:
			get_tree().change_scene_to_file("res://levels/level_3.tscn")
		4: 	
			get_tree().change_scene_to_file("res://levels/stages.tscn")
		5: 
			get_tree().change_scene_to_file("res://levels/menu.tscn")
