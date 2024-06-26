extends Node2D

signal enemy_spawned(enemy_instance)
signal boss_spawned(boss_instance)
signal path_enemy_spawned(path_enemy_instance)

@export var spawns: Array[SpawnInfo] = []

var time = 0
var spawn_position_array : Array

@onready var timer: Timer = $Timer
@onready var enemy_path_timer: Timer = $EnemyPathTimer
@onready var spawn_positions: Node2D = $SpawnPositions

func _ready() -> void:
	timer.connect("timeout", on_timer_timeout)
	spawn_position_array = spawn_positions.get_children()

func on_timer_timeout():
	time += 1
	var enemy_spawns = spawns
	for i in enemy_spawns:
		if time >= i.time_start and time <= i.time_end:
			if i.spawn_delay_counter < i.enemy_spawn_delay:
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0
				var new_enemy = load(str(i.enemy.resource_path))
				var counter = 0 
				while counter < i.enemy_number:
					spawn_enemy(new_enemy)
					counter += 1
		
func spawn_enemy(new_enemy) -> void:
	var enemy_spawn = new_enemy.instantiate()
	if enemy_spawn.name.contains("Boss"):
		var enemy_spawn_position = spawn_position_array[11]
		enemy_spawn.global_position = enemy_spawn_position.global_position
		emit_signal("enemy_spawned", enemy_spawn)
		emit_signal("boss_spawned", enemy_spawn)	
	else:
		var enemy_spawn_position = spawn_position_array.pick_random()
		enemy_spawn.global_position = enemy_spawn_position.global_position
		emit_signal("enemy_spawned", enemy_spawn)

