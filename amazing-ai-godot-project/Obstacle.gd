extends Node2D

var speed = 200

func _process(delta):
	position.y += speed * delta

	if position.y > get_viewport_rect().size.y:
		queue_free()  # Delete the obstacle when it goes off screen
