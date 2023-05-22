extends Node

@export var player_health := 100
@export var player_lives := 3
var score := 0

func increase_score(score_to_add) -> void:
	score += score_to_add
