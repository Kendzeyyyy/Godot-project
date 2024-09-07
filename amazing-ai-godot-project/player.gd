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
	
	# Clamp the player within screen bounds
	var screen_size = get_viewport_rect().size
	var collisionNode = get_node("CollisionShape2D")
	var width = 0
	
	if collisionNode != null:
		width = collisionNode.shape.size.x

	if collision:
		print("Player collided with: ", collision.get_collider())
		get_tree().paused = true  # Pause the game
		
	position.x = clamp(position.x, width/2, screen_size.x-width/2)
	
