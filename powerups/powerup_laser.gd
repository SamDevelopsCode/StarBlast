extends PowerupBase

func _on_body_entered(body) -> void:
	if body is Player:
		body.increase_fire_type()
		queue_free()
