extends BaseEnemy

signal powerup_spawned(powerup_instance)

@export var powerup_scene = preload("res://powerups/powerup.tscn")

var myArray := [1, 2, 3]

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
	var powerup_instance = powerup_scene.instantiate() as Area2D
	powerup_instance.global_position = global_position
	emit_signal("powerup_spawned", powerup_instance)

func should_drop_powerup() -> bool:
	var random_choice = myArray.pick_random()	
	if random_choice == 1:
		return true
	else: 
		return false
