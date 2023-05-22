extends Node

enum GameplayStates { PLAYING, INVULNERABLE }

var current_gameplay_state := GameplayStates.PLAYING

func set_gameplay_state(new_gameplay_state):
	current_gameplay_state = new_gameplay_state
