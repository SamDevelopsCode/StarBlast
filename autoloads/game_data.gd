extends Node

signal score_changed(score)
signal fire_rate_changed(fire_rate)
signal fire_type_changed(fire_type)
signal speed_label_changed(speed_label)
signal player_health_changed(player_health)
signal player_health_refreshed(player_health)
signal player_lives_changed(player_lives)

var player_max_health := 75	
var player_health := 75
var player_lives := 3

var fire_rate = 1
var fire_rate_timer_wait_time = .3
var fire_type = 1
var speed = 400
var speed_label = 1

var score := 0
# var enemies_killed = 0
# powerups collected = 0

func increase_score(score_to_add) -> void:
	score += score_to_add
	emit_signal("score_changed", score)
	
func increase_fire_rate():
	fire_rate_timer_wait_time -= .05
	if fire_rate_timer_wait_time <= .1:
		fire_rate_timer_wait_time = .06
	
	if fire_rate <= 5:
		fire_rate += 1
		emit_signal("fire_rate_changed", fire_rate)	
	else:
		return
		
func decrease_fire_rate():
	if fire_rate <= 1:
		return
	else:
		fire_rate -= 1
		emit_signal("fire_rate_changed", fire_rate)

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
		
func decrease_speed():
	speed -= 100
	if speed <= 400:
		speed = 400
		
	if speed_label >= 2:
		speed_label -= 1
		emit_signal("speed_label_changed", speed_label)	
	else:
		speed_label = 1
		emit_signal("speed_label_changed", speed_label)	
		
func decrease_player_health(damage):
	player_health -= damage
	emit_signal("player_health_changed", player_health)
	
func decrease_player_lives():
	if player_lives <= 1:
		player_lives = 0	
		emit_signal("player_lives_changed", player_lives)
	else:	
		player_lives -= 1
		emit_signal("player_lives_changed", player_lives)

func decrease_fire_type():
	if fire_type <= 1:
		return
	else:
		fire_type -= 1
		emit_signal("fire_type_changed", fire_type)		

func refresh_player_health():
	player_health = player_max_health
	emit_signal("player_health_refreshed", player_max_health)
