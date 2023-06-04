extends Control

var level_1_scene = preload("res://levels/level_1.tscn")


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(level_1_scene)

func _on_choose_stage_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/stages.tscn")
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()


