extends PowerupBase

func _on_body_entered(body) -> void:
	if body is Player:
		GameData.increment_powerups_collected()
		body.increase_fire_rate()
		queue_free()
