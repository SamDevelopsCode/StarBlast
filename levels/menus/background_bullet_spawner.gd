extends Node2D

var laser_scene = preload("res://levels/menus/menu_laser.tscn")

var screen_size

func  _ready() -> void:
	screen_size = get_viewport_rect().size
	print(screen_size)

func _on_spawn_laser_timer_timeout() -> void:
	randomize()
	var laser_instance = laser_scene.instantiate() as Node2D
	laser_instance.global_position = Vector2(randi_range(5, 1275), -100)
	add_child(laser_instance)
