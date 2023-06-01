extends Node2D

signal enemy_spawned(enemy_instance)
signal path_enemy_spawned(path_enemy_instance)

var enemy_scene := preload("res://enemy/enemy.tscn")
var path_enemy_scene := preload("res://enemy/path_enemy.tscn")

@onready var timer: Timer = $Timer
@onready var enemy_path_timer: Timer = $EnemyPathTimer
@onready var spawn_positions: Node2D = $SpawnPositions

#@export var spawns: Array[Resource] = []

func _ready() -> void:
	timer.connect("timeout", spawn_enemy)

func spawn_enemy() -> void:
	var spawn_position_array = spawn_positions.get_children()
	var spawn_position = spawn_position_array.pick_random()
	
	var enemy_instance = enemy_scene.instantiate() as Area2D
	enemy_instance.global_position = spawn_position.global_position
	emit_signal("enemy_spawned", enemy_instance)

func _on_enemy_path_timer_timeout() -> void:
	spawn_path_enemy()

func spawn_path_enemy() -> void:
	var path_enemy_instance = path_enemy_scene.instantiate() as Path2D
	emit_signal("path_enemy_spawned", path_enemy_instance)
