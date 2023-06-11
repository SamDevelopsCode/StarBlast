extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var score_label: Label = $StatsPanel/VBoxContainer/ScoreHorizontal/ScoreLabel
@onready var enemies_killed_label: Label = $StatsPanel/VBoxContainer/EnemiesKilledHorizontal/EnemiesKilledLabel
@onready var powerups_collected_label: Label = $StatsPanel/VBoxContainer/PowerupsCollectedHorizontal/PowerupsCollectedLabel
@onready var play_again_button: Button = $PlayAgainButton

func _ready() -> void:
	await get_tree().create_timer(2.5).timeout
	score_label.text = str(GameData.score)
	await get_tree().create_timer(1.5).timeout
	enemies_killed_label.text = str(GameData.enemies_killed)
	await get_tree().create_timer(1.5).timeout
	powerups_collected_label.text = str(GameData.powerups_collected)

func play_idle_anim():
	animation_player.play("ship_idle")

func _on_play_again_button_pressed() -> void:
	SceneTransitionManager.fade_to_menu()
	MusicController.fade_music_in("menu")
	play_again_button.disabled = true
	
