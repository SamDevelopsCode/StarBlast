extends Node2D

const bullet_scene = preload("res://weapons/enemy/dredge_enemy_bullet.tscn")

@onready var timer: Timer = $Timer
@onready var aim_direction: Marker2D = $AimDirectionMarker


func _ready() -> void:
	randomize()
	timer.wait_time = randf_range(2.0, 5.0)
	

func shoot():
	var bullet = bullet_scene.instantiate() as Node2D
	bullet.direction = aim_direction.global_position - global_position
	bullet.global_position = global_position
	get_parent().get_parent().add_child(bullet)		

func _on_timer_timeout() -> void:
	shoot()
