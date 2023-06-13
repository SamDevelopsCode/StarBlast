extends Node

signal score_changed(score)
signal fire_rate_changed(fire_rate)
signal fire_type_changed(fire_type)
signal speed_label_changed(speed_label)
signal player_health_changed(player_health)
signal player_health_refreshed(player_health)
signal player_lives_changed(player_lives)
signal player_healed(player_health)

var player_max_health := 100
var player_health := 100
var player_lives := 3

var fire_rate = 1
var fire_rate_timer_wait_time = .2
var fire_type = 1
var speed = 400
var speed_label = 1

var score := 0
var enemies_killed := 0
var powerups_collected := 0

func increase_score(score_to_add) -> void:
	score += score_to_add
	emit_signal("score_changed", score)
	
func increase_fire_rate():
	fire_rate_timer_wait_time -= .05
	if fire_rate_timer_wait_time <= .1:
		fire_rate_timer_wait_time = .06
	
	if fire_rate <= 3:
		fire_rate += 1
		print("fire rate: " + str(fire_rate))
		emit_signal("fire_rate_changed", fire_rate)	
	else:
		increase_score(2500)
		return
		
func decrease_fire_rate():
	if fire_rate <= 1:
		return
	else:
		fire_rate -= 1
		emit_signal("fire_rate_changed", fire_rate)
		fire_rate_timer_wait_time += .05
		if fire_rate_timer_wait_time >= .2:
			fire_rate_timer_wait_time = .2		

func increase_fire_type():
	if fire_type <= 3:
		fire_type += 1
		print("fire type: " + str(fire_type))
		emit_signal("fire_type_changed", fire_type)	
	else:
		increase_score(2500)
		return
		
func decrease_fire_type():
	if fire_type <= 1:
		return		
	else:
		fire_type -= 1
		emit_signal("fire_type_changed", fire_type)		

func increase_speed():
	speed += 100
	if speed >= 800:
		speed = 800
		increase_score(2500)
		
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
	
func heal_player():
	player_health += 20
	
	if player_health > player_max_health:
		player_health = player_max_health	
	emit_signal("player_healed", player_health)

func refresh_player_health():
	player_health = player_max_health
	emit_signal("player_health_refreshed", player_max_health)
	
func increment_enemies_killed():
	enemies_killed += 1

func increment_powerups_collected():
	powerups_collected += 1
	
func reset_game_values():
	player_max_health = 100
	player_health = 100
	player_lives = 3
	fire_rate = 1
	fire_rate_timer_wait_time = .2
	fire_type = 1
	speed = 400
	speed_label = 1
	score = 0
	enemies_killed = 0
	powerups_collected = 0
