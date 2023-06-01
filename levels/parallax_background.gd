extends ParallaxBackground

@export var scrolling_speed := 100.0

func _process(delta: float) -> void:
	scroll_offset.y += scrolling_speed * delta
