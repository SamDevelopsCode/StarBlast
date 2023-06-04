extends Area2D

func _on_body_entered(body) -> void:
	if body is Player:
		body.increase_fire_rate()
		queue_free()
