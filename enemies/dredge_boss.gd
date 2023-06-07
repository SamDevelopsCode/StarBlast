extends Area2D

signal boss_died(boss_name)

@export var health := 100
@export var enemy_bullet_scene = preload("res://weapons/enemy/dredge_boss_bullet.tscn")

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var anim_player_gun: AnimationPlayer = $GunAnimationPlayer
@onready var anim_player_movement = $MovementAnimationPlayer
@onready var fire_rate_timer = $FireRateTimer
@onready var gun_turret: Node2D = $GunTurret
@onready var bullet_direction: Marker2D = $GunTurret/BulletDirection

var boss_should_shoot := false
var move_anim_chance := [1, 2, 3]
var gun_anim_chance := [1, 2]

var dead := false

func _ready() -> void:
	anim_player_movement.play("fly_on_screen")

func shoot() -> void:
	var enemy_bullet = enemy_bullet_scene.instantiate() as Node2D
	enemy_bullet.direction = bullet_direction.global_position - gun_turret.global_position
	enemy_bullet.look_at(bullet_direction.global_position)
	enemy_bullet.global_position = gun_turret.global_position
	get_parent().add_child(enemy_bullet)
	
func take_damage(damage) -> void:	
	show_damaged_fx()
	health -= damage
	if dead:
		return
	if health <= 0:
		dead = true
		die()		
		
func _on_body_entered(body: Node2D) -> void:
	body.take_damage()
	body.show_damaged_fx()

func die() -> void:
	sprite.play("death")
	boss_should_shoot = false
	anim_player_movement.pause()
	anim_player_gun.stop()	
	# stop collisions
	#play sound fx for boss
	emit_signal("boss_died", name)
	await get_tree().create_timer(1.5).timeout
	
	#start levl transition cinematic
	queue_free()

func set_boss_should_shoot(should_shoot: bool):
	boss_should_shoot = should_shoot
	
func play_side_to_side_anim():
	anim_player_movement.play("side_to_side")
	
func show_damaged_fx() -> void:
	sprite.set_self_modulate(Color(1, 0.03921568766236, 0.29411765933037, 0.9))
	await get_tree().create_timer(.05).timeout
	sprite.set_self_modulate(Color(1, 1, 1, 1))

func play_random_anim():
	randomize()
	var random_pick = move_anim_chance.pick_random()
	match random_pick:
		1:
			anim_player_movement.play("side_to_side")
		2:
			anim_player_movement.play("swoop_deh_scoop")
		3:
			anim_player_movement.play("twist_to_miss")

func play_random_gun_anim():
	randomize()
	var random_pick = gun_anim_chance.pick_random()
	match random_pick:
		1:
			anim_player_gun.play("rotate_gun_cone")
		2:
			anim_player_gun.play("rotate_gun_circular")



func _on_fire_rate_timer_timeout() -> void:
	if boss_should_shoot:
		shoot()
