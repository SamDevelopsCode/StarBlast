extends Area2D

@export var move_speed := 200

var direction := Vector2.ZERO

@onready var visible_notifier : VisibleOnScreenNotifier2D = $VisibleNotifier2D

func _ready() -> void:
	get_random_direction()
	visible_notifier.connect("screen_exited", queue_free) 

func _on_body_entered(body) -> void:
	if body is Player:
		body.increase_fire_type()
		queue_free()

func get_random_direction() -> void:
	direction = Vector2(randi_range(-5, 5), 5)

func _process(delta) -> void:
	translate(direction.normalized() * move_speed * delta) #randomize direction, speed and clean up
