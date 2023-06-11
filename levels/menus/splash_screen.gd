extends Control

func fade_to_menu():
	SceneTransitionManager.fade_to_menu()

func fade_music_in_from_splash():
	MusicController.fade_music_in("menu")
