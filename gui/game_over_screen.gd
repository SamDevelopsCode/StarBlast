extends Control

var target_value := 0
var start_value := 0
var current_value := 0
var duration := 4.0

@onready var score_label: Label = $Panel/Score

func _process(_delta: float) -> void:
	score_label.text = str(current_value)

func _ready() -> void:		
	target_value = GameData.score
	start_value = current_value
	var tween = get_tree().create_tween()
	tween.tween_property(self, "current_value", target_value, duration)
	

func _on_button_pressed() -> void:
	SceneTransitionManager.fade_to_menu()
