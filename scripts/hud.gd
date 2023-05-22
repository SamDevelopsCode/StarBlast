extends Control

@onready var score: Label = $Score 
@onready var lives_left: Label = $Lives/LivesLeft
@onready var fps_label: Label = $FPS
@onready var player_health_bar = $PlayerHealthBar

func _process(_delta) -> void:
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())

func set_score_label(new_score) -> void:
	score.text = "Score: " + str(new_score)

func set_lives_label(lives) -> void:
	lives_left.text = str(lives)

func set_health_value(health) -> void:
	player_health_bar.value = health
