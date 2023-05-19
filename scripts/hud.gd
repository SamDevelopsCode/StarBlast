extends Control

@onready var score: Label = $Score 
@onready var lives_left: Label = $LivesLeft
@onready var fps_label: Label = $FPS

func _process(_delta) -> void:
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())

func set_score_label(new_score) -> void:
	score.text = "Score: " + str(new_score)

func set_lives_label(lives) -> void:
	lives_left.text = str(lives)
