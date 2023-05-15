extends Area2D

signal enemy_died
signal powerup_spawned(powerup_instance)

@export var move_speed := 100
@export var health := 100

var myArray := [1, 2, 2, 2, 2]

var powerup_scene = preload("res://scenes/powerup.tscn")
var explosion_particle_fx = preload("res://scenes/explosion.tscn")

func _physics_process(delta: float) -> void:
	global_position.y += move_speed * delta

func take_damage():
	show_damage_fx()
	health -= 10
	
	if health < 0:
		die()

func die():
	var explosion_instance = explosion_particle_fx.instantiate() as GPUParticles2D
	explosion_instance.global_position = global_position
	explosion_instance.one_shot = true
	get_parent().add_child(explosion_instance)
	
	emit_signal("enemy_died")
	
	if should_drop_powerup():
		spawn_powerup()
	
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	body.take_damage()
	die()

func spawn_powerup():
	var powerup_instance = powerup_scene.instantiate() as Area2D
	powerup_instance.global_position = global_position
	emit_signal("powerup_spawned", powerup_instance)

func should_drop_powerup() -> bool:
	var random_choice = myArray.pick_random()
	
	if random_choice == 1:
		return true
	else: 
		return false

func show_damage_fx():
	$Sprite2D.set_self_modulate(Color(1, 0, 0, .6))
	await get_tree().create_timer(.05).timeout
	$Sprite2D.set_self_modulate(Color(1, 1, 1, 1))
