extends Control




func _on_stage_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn")


func _on_stage_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_2.tscn")


func _on_stage_3_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_3.tscn")
