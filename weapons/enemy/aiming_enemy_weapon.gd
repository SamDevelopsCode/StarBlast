extends Node2D

const bullet_scene = preload("res://weapons/enemy/dredge_enemy_bullet.tscn")
var weapon_aim_points := []
var player

@onready var weapons: Node2D = $Weapons
@onready var timer: Timer = $Timer

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	weapon_aim_points = weapons.get_children()
	randomize()
	timer.wait_time = randf_range(1.0, 2.0)
	
func shoot():
	var player_direction = player.global_position - global_position
	$Weapons/AimDirectionMarker.look_at(player_direction)
	var bullet = bullet_scene.instantiate()
	bullet.direction = player_direction
	bullet.global_position = weapons.global_position
	get_parent().get_parent().add_child(bullet)		
		
#	for i in weapon_aim_points.size():
#		var bullet = bullet_scene.instantiate()
#		bullet.direction = player_direction
#		bullet.global_position = weapons.global_position
#		get_parent().get_parent().add_child(bullet)		

func _on_timer_timeout() -> void:
	shoot()
