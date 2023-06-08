extends Node2D

var game_over_screen = preload("res://gui/game_over_screen.tscn")

@onready var hud: Control = $UI/HUD
@onready var ui: CanvasLayer = $UI
@onready var enemy_hit_sound: AudioStreamPlayer = $EnemyHitSound
@onready var player_death_sound: AudioStreamPlayer = $PlayerDeathSound
@onready var player: Player = $Player 
@onready var enemy_spawner = $EnemySpawner
@onready var level_events_anim: AnimationPlayer = $LevelEventsAnimationPlayer

func _ready() -> void:
	level_events_anim.play("player_enters_level")
	enemy_spawner.connect("enemy_spawned", _on_enemy_spawner_enemy_spawned)
	player.connect("damage_taken", _on_player_damage_taken)
	hud.set_score_label(GameData.score)
	hud.set_lives_label(GameData.player_lives)
	hud.set_health_label(GameData.player_health)

func _on_enemy_death_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.queue_free()

func _on_player_damage_taken(damage) -> void:
	if player.is_alive:
		GameData.decrease_player_health(damage)
		
		if GameData.player_health <= 0:
			player.is_alive = false
			GameData.decrease_player_lives()
			GameData.decrease_speed()
			GameData.decrease_fire_type()		
			GameData.decrease_fire_rate()	
			
			if GameData.player_lives > 0:
				player.play_out_of_health_anim()
				await get_tree().create_timer(2).timeout
				GameData.refresh_player_health()				
				player.is_alive = true
			
			if GameData.player_lives <= 0:
				GameData.decrease_player_lives()
				player.queue_free()
				player_death_sound.play()				
				await get_tree().create_timer(1.5).timeout
				var game_over_screen_instance = game_over_screen.instantiate()
				ui.add_child(game_over_screen_instance)

func _on_enemy_spawner_enemy_spawned(enemy_instance) -> void:	
	if enemy_instance.name.contains("Boss"):
		enemy_instance.connect("boss_died", _on_boss_died)
		add_child(enemy_instance)
	else: 
		enemy_instance.connect("powerup_spawned", _on_powerup_spawned)
		enemy_instance.connect("enemy_died", _on_enemy_died)
		add_child(enemy_instance)

func _on_enemy_died() -> void:
	randomize()
	GameData.increase_score(randi_range(300, 750))
	enemy_hit_sound.play()

func _on_boss_died(boss_name):
	if boss_name == "DredgeBoss":	
		tween_player_end_level()
		level_events_anim.play("boss_defeated")
	elif boss_name == "FlacianBoss":
		tween_player_end_level()
		level_events_anim.play("boss_defeated")
	elif boss_name == "KameerBoss":
		print("EndGameScreen")

func _on_powerup_spawned(powerup_instance)  -> void:
	call_deferred("add_child", powerup_instance)

func tween_player_end_level():
	var player_tween = get_tree().create_tween()
	player_tween.tween_property(player, "global_position", Vector2(650, 1400), 3.0)
	player.enable_end_of_level_engine_fx()

func start_level_transition_to_2():
	SceneTransitionManager.fade_to_level_2()
	
func start_level_transition_to_3():
	SceneTransitionManager.fade_to_level_3()

func _on_level_events_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "player_enters_level":
		player.set_input_is_valid(false)
		
func _on_level_events_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "player_enters_level":
		player.set_input_is_valid(true)
	if anim_name == "boss_defeated":
		player.set_input_is_valid(false)


