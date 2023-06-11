extends PowerupBase

func _on_body_entered(body) -> void:
	if body is Player:
		GameData.increase_score(25000)
		queue_free()
