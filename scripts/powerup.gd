extends Area2D



func _on_body_entered(body):
	if body is Player:
		body.increase_fire_type()
		queue_free()

func _process(delta):
	global_position.y += 200 * delta  #randomize direction, speed and clean up
