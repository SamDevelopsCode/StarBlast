extends Area2D

func _on_body_entered(body) -> void:
	if body is Player:
		GameData.weapon_type = GameData.WeaponType.BEAM
		queue_free()
