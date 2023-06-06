extends Control

var level_1_scene = preload("res://levels/level_1.tscn")

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var title_label: Label = $TitleLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var menu: Control = $"."

var master_bus = AudioServer.get_bus_index("Master")

func _ready() -> void:
	var fade_label_in = get_tree().create_tween()
	fade_label_in.tween_property(title_label, "modulate", Color(1, 1, 1, 1), 2)
	MusicController.fade_music_in("menu")	

func _on_start_button_pressed() -> void:
	SceneTransitionManager.fade_to_level_1()
	var tween = get_tree().create_tween()
	tween.tween_property(menu, "modulate", Color(1, 1, 1, 0), 1)
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()

func play_idle_anim():
	animation_player.play("ship_idle")

func _on_settings_button_pressed() -> void:
	$SettingsPanel.visible = !$SettingsPanel.visible


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)


func _on_full_screen_toggle_toggled(button_pressed: bool) -> void:
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
