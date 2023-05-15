extends Area2D

signal enemy_died
signal powerup_spawned(powerup_instance)

@export var move_speed := 100

var myArray := [1, 2, 3]

var powerup_scene = preload("res://scenes/powerup.tscn")

func _physics_process(delta: float) -> void:
	global_position.y += move_speed * delta

func die():
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
	elif random_choice == 2:
		return true
	else: 
		return false
