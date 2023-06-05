extends Control

var level_1_scene = preload("res://levels/level_1.tscn")
@onready var v_box_container: VBoxContainer = $VBoxContainer


func _on_start_button_pressed() -> void:
	SceneTransitionManager.play_transition()
	v_box_container.visible = false
	

func _on_choose_stage_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/stages.tscn")
	
func _on_exit_button_pressed() -> void:
	get_tree().quit()


	
