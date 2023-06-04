extends PowerupBase

func _on_body_entered(body) -> void:
	if body is Player:
		body.increase_speed()
		queue_free()
