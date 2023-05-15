extends Control


func set_score_label(score):
	$Panel/Score.text = "Score: " + str(score)

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
