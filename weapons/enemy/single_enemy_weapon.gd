extends Node2D

@export var bullet_scene = Resource

@onready var timer: Timer = $Timer
@onready var aim_direction: Marker2D = $AimDirectionMarker

func _ready() -> void:
	randomize()
	timer.wait_time = randf_range(2.0, 5.0)	

func shoot():
	var bullet = bullet_scene.instantiate() as Node2D
	bullet.direction = aim_direction.global_position - global_position
	bullet.global_position = global_position
	bullet.look_at(aim_direction.global_position)
	get_tree().get_root().add_child(bullet)	

func _on_timer_timeout() -> void:
	shoot()
