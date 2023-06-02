class_name BaseEnemy
extends Area2D

signal enemy_died

@export var move_speed := 100
@export var health := 100
@export var explosion_particle_fx = preload("res://enemies/explosion.tscn")

var dead := false



func take_damage(damage) -> void:
	show_damaged_fx()
	health -= damage
	if dead:
		return
	if health <= 0:
		dead = true
		die()		

func die() -> void:
	var explosion_instance = explosion_particle_fx.instantiate() as GPUParticles2D
	explosion_instance.global_position = global_position
	explosion_instance.one_shot = true
	get_parent().add_child(explosion_instance)	
	emit_signal("enemy_died")
	queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	body.take_damage()
	die()

func show_damaged_fx() -> void:
	$Sprite2D.set_self_modulate(Color(1, 0.03921568766236, 0.29411765933037, 0.9))
	await get_tree().create_timer(.05).timeout
	$Sprite2D.set_self_modulate(Color(1, 1, 1, 1))
