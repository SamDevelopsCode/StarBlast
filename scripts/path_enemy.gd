extends Path2D

@onready var path_follow: PathFollow2D = $PathFollow
@onready var enemy: Area2D = $PathFollow/Enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	path_follow.set_progress_ratio(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress_ratio += .3 * delta
	if path_follow.progress_ratio == 1:
		queue_free()
