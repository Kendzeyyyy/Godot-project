extends Node2D

var speed = 300

func _process(delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	position += direction * speed * delta
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)  # Keep the player on screen
