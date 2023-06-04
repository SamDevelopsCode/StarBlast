extends Node

#@onready var enemy_spawner = get_tree().current_scene.get_node("%EnemySpawner")


#func _ready() -> void:
#	enemy_spawner.connect("boss_spawned", _on_boss_spawned)
	
#func _on_boss_spawned(boss_instance):
#	boss_instance.connect("boss_died", _on_boss_died)
	
#func _on_boss_died(boss_name):
#	if boss_name == "DredgeBoss":
#		get_tree().change_scene_to_file("res://levels/level_2.tscn")
#	elif boss_name == "KareemBoss":
#		pass
##		get_tree().change_scene_to_file("res://levels/level_3.tscn")
		
