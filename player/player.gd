class_name Player
extends CharacterBody2D

signal damage_taken

var move_speed := 400
var fire_type
@export var fire_vibration_weak_magnitude := .5
@export var fire_vibration_strong_magnitude := .5
@export var fire_vibration_length := .5

var laser_scene = preload("res://weapons/laser/laser.tscn")

var screen_size : Vector2
var can_fire := true
var is_alive := true


@onready var laser_container: Node = $LaserContainer
@onready var laser_1_pos = $Weapons/Lasers/Laser1Pos
@onready var laser_2_pos = $Weapons/Lasers/Laser2Pos
@onready var laser_3_pos = $Weapons/Lasers/Laser3Pos
@onready var laser_4_pos = $Weapons/Lasers/Laser4Pos
@onready var laser_5_pos = $Weapons/Lasers/Laser5Pos
@onready var laser_6_pos = $Weapons/Lasers/Laser6Pos
@onready var laser_7_pos = $Weapons/Lasers/Laser7Pos
@onready var laser_8_pos = $Weapons/Lasers/Laser8Pos
@onready var laser_9_pos = $Weapons/Lasers/Laser9Pos
@onready var weapon_sound: AudioStreamPlayer = $WeaponSound
@onready var engine_fx: GPUParticles2D = $EngineFX
@onready var player_animations = $AnimationPlayer
@onready var fire_rate_timer: Timer = $FireRateTimer


func _ready() -> void:
	fire_type = GameData.fire_type
	fire_rate_timer.wait_time = GameData.fire_rate_timer_wait_time
	move_speed = GameData.speed
	
	screen_size = get_viewport_rect().size
	global_position = Vector2(screen_size.x/2, screen_size.y - 300)

func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot") and can_fire:
		shoot()

func _physics_process(_delta: float) -> void:
	move_player()

func move_player():
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
	fire_lasers()

func fire_lasers():
	can_fire = false
	fire_rate_timer.start()
	weapon_sound.play()
	add_vibration()
	
	match fire_type:
		1:
			add_laser_projectile(laser_1_pos)
		2:
			add_laser_projectile(laser_1_pos)
			add_laser_projectile(laser_2_pos)
			add_laser_projectile(laser_3_pos)
		3:
			add_laser_projectile(laser_1_pos)
			add_laser_projectile(laser_2_pos)
			add_laser_projectile(laser_3_pos)
			add_laser_projectile(laser_4_pos)
			add_laser_projectile(laser_5_pos)
		4:
			add_laser_projectile(laser_1_pos)
			add_laser_projectile(laser_2_pos)
			add_laser_projectile(laser_3_pos)
			add_laser_projectile(laser_4_pos)
			add_laser_projectile(laser_5_pos)
			add_laser_projectile(laser_6_pos)
			add_laser_projectile(laser_7_pos)
			add_laser_projectile(laser_8_pos)
			add_laser_projectile(laser_9_pos)

func fire_beam():
	pass

func add_laser_projectile(laser_identifier) -> void:
	var laser_instance = laser_scene.instantiate() as Area2D
	laser_instance.global_position = laser_identifier.global_position
	laser_instance.direction = laser_instance.global_position - global_position
	laser_container.add_child(laser_instance)

func increase_fire_type() -> void:	
	GameData.increase_fire_type()
	fire_type += 1
	if fire_type > 4:
		fire_type = 4
		GameData.increase_score(750)

func increase_fire_rate():
	GameData.increase_fire_rate()
	fire_rate_timer.wait_time -= .05
	if fire_rate_timer.wait_time <= .1:
		fire_rate_timer.wait_time = .06
		GameData.increase_score(750)

func increase_speed():
	GameData.increase_speed()
	move_speed += 100
	if move_speed >= 800:
		move_speed = 800
		GameData.increase_score(750)

func _on_fire_rate_timer_timeout() -> void:
	can_fire = true

func play_out_of_health_anim() -> void:
	player_animations.play("out_of_health")

func add_vibration() -> void:
	Input.start_joy_vibration(0,
		fire_vibration_weak_magnitude,
		fire_vibration_strong_magnitude,
		fire_vibration_length)
		
func take_damage() -> void:
	emit_signal("damage_taken")
