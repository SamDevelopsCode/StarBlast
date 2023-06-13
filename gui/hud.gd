extends Control

@onready var score: Label = $Score
@onready var lives_left: Label = $Lives/LivesLeft
@onready var player_health_bar = $VBox/PlayerHealthBar
@onready var fire_rate_label: Label = $"FireRate/FireRate"
@onready var fire_type_label: Label = $FireType/FireType
@onready var speed_label: Label = $Speed/Speed

func _ready() -> void:
	GameData.connect("score_changed", set_score_label)	
	GameData.connect("fire_rate_changed", set_fire_rate_label)	
	GameData.connect("fire_type_changed", set_fire_type_label)	
	GameData.connect("speed_label_changed", set_speed_label)	
	GameData.connect("player_health_changed", set_health_label)	
	GameData.connect("player_lives_changed", set_lives_label)	
	GameData.connect("player_health_refreshed", set_health_label)
	GameData.connect("player_healed", set_health_label)
	
	
	set_fire_rate_label(GameData.fire_rate)
	set_fire_type_label(GameData.fire_type)
	set_speed_label(GameData.speed_label)
	set_lives_label(GameData.player_lives)

func set_score_label(new_score) -> void:
	score.text = "Score: " + str(new_score)

func set_health_label(health):
	player_health_bar.value = health

func set_lives_label(lives) -> void:
	lives_left.text = str(lives)

func set_fire_rate_label(fire_rate) -> void:
	fire_rate_label.text = str(fire_rate)	
	if fire_rate >= 4:
		fire_rate_label.text = "max"	

func set_fire_type_label(fire_type) -> void:
	fire_type_label.text = str(fire_type)	
	if fire_type >= 4:
		fire_type_label.text = "max"

func set_speed_label(speed) -> void:
	speed_label.text = str(speed)
	if speed >= 6:
		speed_label.text = "max"
	
