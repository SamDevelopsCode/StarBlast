extends Area2D

signal enemy_died
signal powerup_spawned(powerup_instance)

@export var move_speed := 100
@export var health := 100

var powerup_laser = preload("res://powerups/powerup_laser.tscn")
var powerup_speed = preload("res://powerups/powerup_speed.tscn")
var powerup_fire_rate = preload("res://powerups/powerup_fire_rate.tscn")
var powerup_health = preload("res://powerups/powerup_health.tscn")
var powerup_score = preload("res://powerups/powerup_score.tscn")

var powerups = [powerup_laser,  powerup_fire_rate, powerup_speed, powerup_health, powerup_score]
var powerup_spawn_chance := [1, 2, 2, 2, 2, 2, 2, 2, 2] # 12.5% spawn chance
var powerup_type_chance := [1, 2, 3, 4, 5]

var dead := false

@onready var sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta: float) -> void:
	global_position.y += move_speed * delta

func take_damage(damage) -> void:	
	if dead:
		return
	show_damaged_fx()
	health -= damage	
	if health <= 0:
		dead = true
		die()

func die() -> void:	
	set_collision_layer_value(2, false)
	set_collision_mask_value(1, false)	
	set_collision_mask_value(3, false)	
	var enemy_children = get_children()
	for component in enemy_children:
		if component.name.contains("Weapon"):
			component.queue_free()	
	sprite.play("death")
	emit_signal("enemy_died")	
	GameData.increment_enemies_killed()
	if should_drop_powerup():
		spawn_powerup()	
	
func _on_body_entered(body: Node2D) -> void:
	take_damage(5)
	body.take_damage(20)
	body.show_damaged_fx()
	
func show_damaged_fx() -> void:
	sprite.set_self_modulate(Color(1, 0.03921568766236, 0.29411765933037, 0.9))
	await get_tree().create_timer(.05).timeout
	sprite.set_self_modulate(Color(1, 1, 1, 1))	

func spawn_powerup() -> void:
	randomize()
	var random_pick = powerup_type_chance.pick_random()
	match random_pick:
		1:
			var powerup_instance = powerup_laser.instantiate() as Area2D
			powerup_instance.global_position = global_position
			emit_signal("powerup_spawned", powerup_instance)
		2:
			var powerup_instance = powerup_fire_rate.instantiate() as Area2D
			powerup_instance.global_position = global_position
			emit_signal("powerup_spawned", powerup_instance)
		3:
			var powerup_instance = powerup_speed.instantiate() as Area2D
			powerup_instance.global_position = global_position
			emit_signal("powerup_spawned", powerup_instance)	
		4:
			var powerup_instance = powerup_health.instantiate() as Area2D
			powerup_instance.global_position = global_position
			emit_signal("powerup_spawned", powerup_instance)	
		5:
			var powerup_instance = powerup_score.instantiate() as Area2D
			powerup_instance.global_position = global_position
			emit_signal("powerup_spawned", powerup_instance)	

func should_drop_powerup() -> bool:
	randomize()
	var random_choice = powerup_spawn_chance.pick_random()	
	if random_choice == 1:
		return true
	else: 
		return false

func _on_sprite_animation_finished() -> void:
	queue_free()
