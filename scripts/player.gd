extends CharacterBody2D
class_name Player

signal damage_taken

var laser_scene := preload("res://scenes/laser.tscn")

@onready var laser_container: Node = $LaserContainer
@onready var laser_1_pos = $Laser1Pos
@onready var laser_2_pos = $Laser2Pos
@onready var laser_3_pos = $Laser3Pos
@onready var laser_4_pos = $Laser4Pos
@onready var laser_5_pos = $Laser5Pos
@onready var laser_6_pos = $Laser6Pos
@onready var laser_7_pos = $Laser7Pos
@onready var laser_8_pos = $Laser8Pos
@onready var laser_9_pos = $Laser9Pos
@onready var laser_10_pos = $Laser10Pos
@onready var laser_11_pos = $Laser11Pos

@onready var weapon_sound: AudioStreamPlayer = $WeaponSound
@onready var engine_fx: GPUParticles2D = $EngineFX
@onready var player_animations = $AnimationPlayer

@export var move_speed := 100
@export var fire_type := 1
@export var fire_vibration_weak_magnitude := .5
@export var fire_vibration_strong_magnitude := .5
@export var fire_vibration_length := .5

var screen_size : Vector2
@export var can_fire := true
var is_alive := true

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot") and can_fire:
		shoot()

func _physics_process(_delta: float) -> void:
	
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * move_speed
	if velocity.y < 0:
		engine_fx.emitting = true
	else:
		engine_fx.emitting = false
	move_and_slide()
	
	global_position.x = clampf(global_position.x, 26, screen_size.x - 26)
	global_position.y = clampf(global_position.y, 18, screen_size.y - 18)

func shoot() -> void:
	can_fire = false
	$FireRateTimer.start()
	
	if fire_type == 1:
		weapon_sound.play()
		add_vibration()
		add_laser_projectile(laser_1_pos)
	if fire_type == 2:
		weapon_sound.play()
		add_vibration()
		add_laser_projectile(laser_2_pos)
		add_laser_projectile(laser_3_pos)
	if fire_type == 3:
		weapon_sound.play()
		add_vibration()
		add_laser_projectile(laser_1_pos)
		add_laser_projectile(laser_2_pos)
		add_laser_projectile(laser_3_pos)
	if fire_type == 4:
		weapon_sound.play()
		add_vibration()
		add_laser_projectile(laser_1_pos)
		add_laser_projectile(laser_2_pos)
		add_laser_projectile(laser_3_pos)
		add_laser_projectile(laser_4_pos)
		add_laser_projectile(laser_5_pos)
	if fire_type == 5:
		weapon_sound.play()
		add_vibration()
		add_laser_projectile(laser_1_pos)
		add_laser_projectile(laser_2_pos)
		add_laser_projectile(laser_3_pos)
		add_laser_projectile(laser_4_pos)
		add_laser_projectile(laser_5_pos)
		add_laser_projectile(laser_6_pos)
		add_laser_projectile(laser_7_pos)
	if fire_type == 6:
		weapon_sound.play()
		add_vibration()
		add_laser_projectile(laser_1_pos)
		add_laser_projectile(laser_2_pos)
		add_laser_projectile(laser_3_pos)
		add_laser_projectile(laser_4_pos)
		add_laser_projectile(laser_5_pos)
		add_laser_projectile(laser_6_pos)
		add_laser_projectile(laser_7_pos)
		add_laser_projectile(laser_8_pos)
		add_laser_projectile(laser_9_pos)
	if fire_type == 7:
		weapon_sound.play()
		add_vibration()
		add_laser_projectile(laser_1_pos)
		add_laser_projectile(laser_2_pos)
		add_laser_projectile(laser_3_pos)
		add_laser_projectile(laser_4_pos)
		add_laser_projectile(laser_5_pos)
		add_laser_projectile(laser_6_pos)
		add_laser_projectile(laser_7_pos)
		add_laser_projectile(laser_8_pos)
		add_laser_projectile(laser_9_pos)
		add_laser_projectile(laser_10_pos)
		add_laser_projectile(laser_11_pos)

func take_damage() -> void:
	emit_signal("damage_taken")

func add_vibration() -> void:
	Input.start_joy_vibration(0,
		fire_vibration_weak_magnitude,
		fire_vibration_strong_magnitude,
		fire_vibration_length)

func add_laser_projectile(laser_identifier) -> void:
	var laser_instance = laser_scene.instantiate() as Area2D
	laser_instance.global_position = laser_identifier.global_position
	laser_instance.direction = laser_instance.global_position - global_position
	laser_container.add_child(laser_instance)

func increase_fire_type() -> void:
	fire_type += 1
	
	if fire_type > 7:
		fire_type = 7
		GameData.increase_score(randi_range(500,750))


func _on_fire_rate_timer_timeout() -> void:
	can_fire = true

func play_out_of_health_anim() -> void:
	player_animations.play("out_of_health")
