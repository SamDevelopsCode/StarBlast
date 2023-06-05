extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_transition():
	animation_player.play("scene_transition")
	
func change_level():
	get_tree().change_scene_to_file("res://levels/level_1.tscn")
