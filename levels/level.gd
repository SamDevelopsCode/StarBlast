extends Node2D

@onready var hud: Control = $UI/HUD
@onready var ui: CanvasLayer = $UI
@onready var enemy_hit_sound: AudioStreamPlayer = $EnemyHitSound
@onready var player_death_sound: AudioStreamPlayer = $PlayerDeathSound
@onready var player: Player = $Player 

var game_over_screen = preload("res://scenes/game_over_screen.tscn")

func _ready() -> void:
	hud.set_score_label(GameData.score)
	hud.set_lives_label(GameData.player_lives)
	hud.set_health_value(100)

func _on_enemy_death_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.queue_free()

func _on_player_damage_taken() -> void:
	if player.is_alive:
		GameData.player_health -= 1
		hud.set_health_value(GameData.player_health)
		
		if GameData.player_health <= 0:
			player.is_alive = false
			GameData.player_lives -= 1
			hud.set_lives_label(GameData.player_lives)
			
			if GameData.player_lives > 0:
				player.play_out_of_health_anim()
				await get_tree().create_timer(2).timeout
				GameData.refresh_player_health()
				hud.set_health_value(GameData.player_health)
				player.is_alive = true
			
			if GameData.player_lives <= 0:
				hud.set_lives_label(GameData.player_lives)
				player.queue_free()
				player_death_sound.play()
				
				await get_tree().create_timer(1.5).timeout
				var game_over_screen_instance = game_over_screen.instantiate()
				game_over_screen_instance.set_score_label(GameData.score)
				ui.add_child(game_over_screen_instance)

func _on_enemy_spawner_enemy_spawned(enemy_instance) -> void:
	enemy_instance.connect("powerup_spawned", _on_powerup_spawned)
	enemy_instance.connect("enemy_died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance) -> void:
#	path_enemy_instance.connect("enemy_died", _on_enemy_died)
	add_child(path_enemy_instance)

func _on_enemy_died() -> void:
	GameData.score += randi_range(10, 25)
	hud.set_score_label(GameData.score)
	enemy_hit_sound.play()

func _on_powerup_spawned(powerup_instance)  -> void:
	call_deferred("add_child", powerup_instance)
