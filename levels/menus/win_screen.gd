extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func play_idle_anim():
	animation_player.play("ship_idle")

