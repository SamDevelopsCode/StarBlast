extends Area2D

signal enemy_died
signal powerup_spawned(powerup_instance)

@export var move_speed := 100
@export var health := 100
@export var powerup_scene = preload("res://powerups/powerup.tscn")
@export var explosion_particle_fx = preload("res://enemy/explosion.tscn")

var myArray := [1, 1]
var dead := false

func _ready() -> void:
	move_speed = randi_range(200, 500)

func _physics_process(delta: float) -> void:
	global_position.y += move_speed * delta

func take_damage(damage) -> void:
	show_damaged_fx()
	health -= damage
	if dead:
		return
	
	if health <= 0:
		dead = true
		die()

func die() -> void:
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

func show_damaged_fx() -> void:
	$Sprite2D.set_self_modulate(Color(1, 0, 0, .6))
	await get_tree().create_timer(.05).timeout
	$Sprite2D.set_self_modulate(Color(1, 1, 1, 1))
