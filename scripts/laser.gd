extends Area2D

var direction = Vector2.UP
@export var speed := 1000
@onready var visible_notifier : VisibleOnScreenNotifier2D = $VisibleNotifier2D

func _ready() -> void:
	visible_notifier.connect("screen_exited", queue_free)

func _physics_process(delta: float) -> void:
	translate(direction.normalized() * speed * delta)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.take_damage()
		queue_free()
