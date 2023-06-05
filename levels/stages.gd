extends Control


@onready var grid_container: GridContainer = $CenterContainer/GridContainer


func _on_stage_1_button_pressed() -> void:
	SceneTransitionManager.fade_to_level_1()
	var tween = get_tree().create_tween()
	tween.tween_property(grid_container, "modulate", Color(1, 1, 1, 0), 1)
	

func _on_stage_2_button_pressed() -> void:
	SceneTransitionManager.fade_to_level_2()
	var tween = get_tree().create_tween()
	tween.tween_property(grid_container, "modulate", Color(1, 1, 1, 0), 1)
	

func _on_stage_3_button_pressed() -> void:
	SceneTransitionManager.fade_to_level_3()
	var tween = get_tree().create_tween()
	tween.tween_property(grid_container, "modulate", Color(1, 1, 1, 0), 1)
	

func _on_main_menu_button_pressed() -> void:
	SceneTransitionManager.fade_to_menu()
	var tween = get_tree().create_tween()
	tween.tween_property(grid_container, "modulate", Color(1, 1, 1, 0), .75)
