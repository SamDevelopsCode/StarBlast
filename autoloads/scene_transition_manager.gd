extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var panel: Panel = $Panel
@onready var quit_game_button: Button = $Panel/VBoxContainer/QuitGameButton

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("pause_game") and get_tree().current_scene.name == "Level1") \
	or (event.is_action_pressed("pause_game") and get_tree().current_scene.name == "Level2") \
	or (event.is_action_pressed("pause_game") and get_tree().current_scene.name == "Level3"):
		
		var current_value : bool = get_tree().paused
		get_tree().paused = !current_value
		
		if get_tree().paused == true:
			panel.visible = true
			quit_game_button.disabled = false
			quit_game_button.grab_focus()
		elif get_tree().paused == false: 
			panel.visible = false
			quit_game_button.disabled = true	
			quit_game_button.release_focus()					
		
	if event.is_action_pressed("quit_game"):
		get_tree().quit()

func fade_to_level_1():
	animation_player.play("fade_to_level_1")
	MusicController.fade_music_in("level_1_music")

func fade_to_level_2():
	animation_player.play("fade_to_level_2")
	MusicController.fade_music_in("level_2_music")
	
func fade_to_level_3():
	animation_player.play("fade_to_level_3")
	MusicController.fade_music_in("level_3_music")
	
func fade_to_win_screen():
	animation_player.play("fade_to_win_screen")
	MusicController.fade_music_in("menu")		
	
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
			get_tree().change_scene_to_file("res://levels/menus/win_screen.tscn")
		5: 
			get_tree().change_scene_to_file("res://levels/menus/menu.tscn")

func _on_button_pressed() -> void:
	get_tree().quit()
