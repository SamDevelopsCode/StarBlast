extends Node2D

@export var bullet_scene = Resource

var player
var weapon_array

@onready var weapons: Node2D = $Weapons
@onready var timer: Timer = $Timer

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	weapon_array = weapons.get_children()
	randomize()
	timer.wait_time = randf_range(3.0, 5.0)

func shoot():
	if Player:
		weapons.look_at(player.global_position)
		for weapon in weapon_array:
			var bullet = bullet_scene.instantiate()
			bullet.global_position = weapons.global_position
			bullet.look_at(weapon.global_position)
			bullet.direction = weapon.global_position - weapons.global_position
			get_tree().get_root().add_child(bullet)	
	
func _on_timer_timeout() -> void:
	shoot()
