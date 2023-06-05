extends Control

var level_1_scene = preload("res://levels/level_1.tscn")

@onready var v_box_container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	MusicController.fade_music_in("menu")
	

func _on_start_button_pressed() -> void:
	SceneTransitionManager.fade_to_level_1()
	var tween = get_tree().create_tween()
	tween.tween_property(v_box_container, "modulate", Color(1, 1, 1, 0), 1)
	
func _on_choose_stage_button_pressed() -> void:
	SceneTransitionManager.fade_to_choose_stage()
	var tween = get_tree().create_tween()
	tween.tween_property(v_box_container, "modulate", Color(1, 1, 1, 0), .75)
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()
