extends PowerupBase

func _on_body_entered(body) -> void:
	if body is Player:
		GameData.weapon_type = GameData.WeaponType.LASER
		body.increase_fire_type()
		queue_free()
