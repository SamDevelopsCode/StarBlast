extends BaseEnemy

signal boss_died(boss_name)

@export var enemy_bullet_scene = preload("res://enemies/enemy_bullet.tscn")

@onready var anim_player_movement = $MovementAnimationPlayer
@onready var fire_rate_timer = $FireRateTimer
@onready var gun_turret: Node2D = $GunTurret
@onready var bullet_direction: Marker2D = $GunTurret/BulletDirection

var boss_should_shoot := false

func _ready() -> void:
	anim_player_movement.play("fly_on_screen")

func _physics_process(_delta: float) -> void:
	if boss_should_shoot:
		shoot()

func shoot() -> void:
	var enemy_bullet = enemy_bullet_scene.instantiate() as Node2D
	enemy_bullet.direction = bullet_direction.global_position - gun_turret.global_position
	enemy_bullet.global_position = gun_turret.global_position
	get_parent().add_child(enemy_bullet)
	
func die() -> void:
	var explosion_instance = explosion_particle_fx.instantiate() as GPUParticles2D
	explosion_instance.global_position = global_position
	explosion_instance.one_shot = true
	get_parent().add_child(explosion_instance)	
	emit_signal("boss_died", name)
	queue_free()

func set_boss_should_shoot(should_shoot: bool):
	boss_should_shoot = should_shoot
	
func play_side_to_side_anim():
	anim_player_movement.play("side_to_side")
