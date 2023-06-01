extends Area2D

@export var speed := 1000

var direction = Vector2.UP

@onready var visible_notifier := $VisibleNotifier2D

func _ready() -> void:
	visible_notifier.connect("screen_exited", queue_free)

func _physics_process(delta: float) -> void:
	translate(direction.normalized() * speed * delta)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.take_damage()
		queue_free()
