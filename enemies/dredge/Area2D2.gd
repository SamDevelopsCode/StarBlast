extends CharacterBody2D

@export var speed = 100

func _process(delta: float) -> void:
	
	var input_vector = Input.get_vector("move_left","move_right","move_up", "move_down")
	velocity = input_vector * speed
	
	move_and_slide()
	
	if $RayCast2D.get_collider() == null:
		return
	elif $RayCast2D.get_collider().name == "npc" and Input.is_action_just_pressed("shoot"):
		print("I got the dummy guy")
