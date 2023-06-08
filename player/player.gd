class_name Player
extends CharacterBody2D

signal damage_taken(damage)

@export var fire_vibration_weak_magnitude := .5
@export var fire_vibration_strong_magnitude := .5
@export var fire_vibration_length := .5

var move_speed := 400
var fire_type

var laser_scene = preload("res://weapons/laser/laser.tscn")
var powerup_laser = preload("res://powerups/powerup_laser.tscn")
var powerup_speed = preload("res://powerups/powerup_speed.tscn")
var powerup_fire_rate = preload("res://powerups/powerup_fire_rate.tscn")

var screen_size : Vector2
var can_fire
var is_alive := true
var input_is_valid

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
@onready var animated_engine_fx: AnimatedSprite2D = $AnimatedEngineFx


func _ready() -> void:
	fire_type = GameData.fire_type
	fire_rate_timer.wait_time = GameData.fire_rate_timer_wait_time
	move_speed = GameData.speed	
	screen_size = get_viewport_rect().size
	animated_engine_fx.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot") and can_fire:
		shoot()

func _physics_process(_delta: float) -> void:
	if input_is_valid:
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
	if input_is_valid:
		fire_lasers()

func fire_lasers():
	can_fire = false
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

func add_laser_projectile(laser_identifier) -> void:
	var laser_instance = laser_scene.instantiate() as Area2D
	laser_instance.global_position = laser_identifier.global_position
	laser_instance.direction = laser_instance.global_position - global_position
	get_tree().get_root().add_child(laser_instance)

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
		
func take_damage(amount) -> void:
	emit_signal("damage_taken", amount)

func show_damaged_fx() -> void:
	$Sprite2D.set_self_modulate(Color(1, 0.03921568766236, 0.29411765933037, 0.9))
	await get_tree().create_timer(.05).timeout
	$Sprite2D.set_self_modulate(Color(1, 1, 1, 1))

func _on_hurt_box_area_entered(area: Area2D) -> void:
	take_damage(2)
	show_damaged_fx()
	area.queue_free()

func enable_end_of_level_engine_fx():
	animated_engine_fx.visible = true
	animated_engine_fx.play("fire_engine")
	
func disable_end_of_level_engine_fx():
	animated_engine_fx.visible = false
	animated_engine_fx.stop()
	
func set_input_is_valid(is_valid: bool):
	input_is_valid = is_valid
