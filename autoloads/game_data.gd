extends Node

signal score_changed(score)

@export var player_health := 100
@export var player_lives := 3

var score := 0
enum WeaponType { LASER, BEAM }
var weapon_type

func _ready() -> void:
	weapon_type = WeaponType.LASER

func increase_score(score_to_add) -> void:
	score += score_to_add
	emit_signal("score_changed", score)

func refresh_player_health():
	player_health = 100

