extends BaseEnemy

@export var enemy_bullet_scene = preload("res://enemy_bullet.tscn")

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

func shoot():
	var enemy_bullet = enemy_bullet_scene.instantiate() as Node2D
	enemy_bullet.direction = bullet_direction.global_position - gun_turret.global_position
	enemy_bullet.global_position = gun_turret.global_position
	get_parent().add_child(enemy_bullet)
	

func set_boss_should_shoot(should_shoot: bool):
	boss_should_shoot = should_shoot
	
func play_side_to_side_anim():
	anim_player_movement.play("side_to_side")
