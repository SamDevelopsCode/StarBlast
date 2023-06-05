extends Node

signal score_changed(score)
signal fire_rate_label_changed(fire_rate)
signal fire_type_changed(fire_type)
signal speed_label_changed(speed_label)

@export var player_health := 100
@export var player_lives := 3

var fire_rate = 1
var fire_rate_timer_wait_time = .3
var fire_type = 1
var speed = 400
var speed_label = 1
var score := 0

func increase_score(score_to_add) -> void:
	score += score_to_add
	emit_signal("score_changed", score)
	
func increase_fire_rate():
	fire_rate_timer_wait_time -= .05
	if fire_rate_timer_wait_time <= .1:
		fire_rate_timer_wait_time = .06
	
	if fire_rate <= 5:
		fire_rate += 1
		emit_signal("fire_rate_label_changed", fire_rate)	
	else:
		return

func increase_fire_type():
	if fire_type <= 3:
		fire_type += 1
		emit_signal("fire_type_changed", fire_type)	
	else:
		return

func increase_speed():
	speed += 100
	if speed >= 800:
		speed = 800
		
	if speed_label <= 5:
		speed_label += 1
		emit_signal("speed_label_changed", speed_label)	
	else:
		return

func refresh_player_health():
	player_health = 100
