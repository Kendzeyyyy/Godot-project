extends CharacterBody2D

@export var speed: float = 200.0  # Speed of the falling obstacle

func _process(delta: float) -> void:
	# Move the obstacle downwards
	var velocity2 = Vector2(0, speed * delta)

	# Move and detect collisions
	var collision = move_and_collide(velocity2)
	
	# Log if a collision occurs
	if collision:
		print("Obstacle collided with: ", collision.get_collider())
	
	# Free the obstacle if it goes off-screen (optional)
	if position.y > get_viewport_rect().size.y:
		queue_free()
