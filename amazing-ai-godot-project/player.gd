extends CharacterBody2D

@export var speed: float = 500.0  # Speed of the player

func _process(delta: float) -> void:
	var direction = Vector2.ZERO

	# Movement: left and right using arrow keys or A/D keys
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	# Normalize the direction to prevent diagonal speed boost
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	# Calculate the velocity
	var velocity2 = direction * speed * delta

	# Move the player and detect collisions
	var collision = move_and_collide(velocity2)
	
	# Log if a collision occurs
	if collision:
		print("Player collided with: ", collision.get_collider())

	# Clamp the player within screen bounds
	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 0, screen_size.x)
