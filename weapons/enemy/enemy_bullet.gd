extends Area2D

@export var speed := 1000

var direction = Vector2.DOWN

@onready var visible_notifier: VisibleOnScreenNotifier2D = $VisibleNotifier2D

func _ready() -> void:
	visible_notifier.connect("screen_exited", queue_free)

func _physics_process(delta: float) -> void:
	translate(direction.normalized() * speed * delta)