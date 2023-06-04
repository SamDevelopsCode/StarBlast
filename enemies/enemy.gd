extends BaseEnemy

signal powerup_spawned(powerup_instance)

var powerup_laser = preload("res://powerups/powerup_laser.tscn")
var powerup_speed = preload("res://powerups/powerup_speed.tscn")
var powerup_fire_rate = preload("res://powerups/powerup_fire_rate.tscn")

var powerups = [powerup_laser, powerup_speed, powerup_fire_rate]

var myArray := [1, 1]

func _physics_process(delta: float) -> void:
	global_position.y += move_speed * delta

func die() -> void:
	var explosion_instance = explosion_particle_fx.instantiate() as GPUParticles2D
	explosion_instance.global_position = global_position
	explosion_instance.one_shot = true
	get_parent().add_child(explosion_instance)
	
	emit_signal("enemy_died")
	
	if should_drop_powerup():
		spawn_powerup()
	
	queue_free()

func spawn_powerup() -> void:
	var powerup_instance = powerups.pick_random().instantiate() as Area2D
	powerup_instance.global_position = global_position
	emit_signal("powerup_spawned", powerup_instance)

func should_drop_powerup() -> bool:
	var random_choice = myArray.pick_random()	
	if random_choice == 1:
		return true
	else: 
		return false
