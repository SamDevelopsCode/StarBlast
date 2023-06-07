extends Area2D

signal enemy_died
signal powerup_spawned(powerup_instance)

@export var move_speed := 100
@export var health := 100

var powerup_laser = preload("res://powerups/powerup_laser.tscn")
var powerup_speed = preload("res://powerups/powerup_speed.tscn")
var powerup_fire_rate = preload("res://powerups/powerup_fire_rate.tscn")
var powerups = [powerup_laser, powerup_speed, powerup_fire_rate]

var myArray := [1, 2, 2, 2, 2, 2, 2]
var powerup_chance := [1, 1, 1, 1, 1, 2, 2 ,2, 3, 3]

var dead := false

@onready var sprite: AnimatedSprite2D = $Sprite

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
	set_collision_layer_value(2, false)
	sprite.play("death")
	emit_signal("enemy_died")	
	if should_drop_powerup():
		spawn_powerup()		
	
func _on_body_entered(body: Node2D) -> void:
	body.take_damage()
	body.show_damaged_fx()
	die()
	
func show_damaged_fx() -> void:
	sprite.set_self_modulate(Color(1, 0.03921568766236, 0.29411765933037, 0.9))
	await get_tree().create_timer(.05).timeout
	sprite.set_self_modulate(Color(1, 1, 1, 1))	

func spawn_powerup() -> void:
	randomize()
	var random_pick = powerup_chance.pick_random()
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

func should_drop_powerup() -> bool:
	randomize()
	var random_choice = myArray.pick_random()	
	if random_choice == 1:
		return true
	else: 
		return false


func _on_sprite_animation_finished() -> void:
	queue_free()
