extends Control

@onready var score: Label = $Score
@onready var lives_left: Label = $Lives/LivesLeft
@onready var player_health_bar = $VBox/PlayerHealthBar
@onready var fire_rate_label: Label = $"FireRate/FireRate"
@onready var fire_type_label: Label = $FireType/FireType
@onready var speed_label: Label = $Speed/Speed

func _ready() -> void:
	GameData.connect("score_changed", set_score_label)	
	GameData.connect("fire_rate_label_changed", set_fire_rate_label)	
	GameData.connect("fire_type_changed", set_fire_type_label)	
	GameData.connect("speed_label_changed", set_speed_label)		
	
	set_fire_rate_label(GameData.fire_rate)
	set_fire_type_label(GameData.fire_type)
	set_speed_label(GameData.speed_label)
	
	


func set_score_label(new_score) -> void:
	score.text = "Score: " + str(new_score)

func set_lives_label(lives) -> void:
	lives_left.text = str(lives)

func set_health_value(health) -> void:
	player_health_bar.value = health

func set_fire_rate_label(fire_rate) -> void:
	if fire_rate >= 6:
		fire_rate_label.text = "max"
	else:		
		fire_rate_label.text = str(fire_rate)

func set_fire_type_label(fire_type) -> void:
	if fire_type >= 4:
		fire_type_label.text = "max"
	else:
		fire_type_label.text = str(fire_type)

func set_speed_label(speed) -> void:
	if speed >= 6:
		speed_label.text = "max"
	else:		
		speed_label.text = str(speed)
