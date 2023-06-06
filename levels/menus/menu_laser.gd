extends Area2D

@export var speed = 3000


var laser_1 = preload("res://assets_third_party/laser_sprite/11.png") 
var laser_2 = preload("res://assets_third_party/laser_sprite/12.png") 
var laser_3 = preload("res://assets_third_party/laser_sprite/13.png") 
var laser_4 = preload("res://assets_third_party/laser_sprite/14.png") 
var laser_5 = preload("res://assets_third_party/laser_sprite/15.png") 
var laser_6 = preload("res://assets_third_party/laser_sprite/16.png") 
var laser_7 = preload("res://assets_third_party/laser_sprite/17.png") 
var laser_8 = preload("res://assets_third_party/laser_sprite/18.png") 
var laser_9 = preload("res://assets_third_party/laser_sprite/19.png") 
var laser_10 = preload("res://assets_third_party/laser_sprite/20.png") 


var laser_array = [laser_1, laser_2, laser_3, laser_4,
 laser_5, laser_6, laser_7, laser_8, laser_9, laser_10]

func _ready() -> void:
	randomize()
	$Sprite2D.texture = laser_array.pick_random()

func _process(delta: float) -> void:
	translate(Vector2.DOWN * delta * speed)
	
	if global_position.y > 2100:
		queue_free()
