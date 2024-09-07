extends RigidBody2D

# Speed at which the block falls
@export var fall_speed = 200.0

func _ready():
	# Set initial downward velocity
	linear_velocity = Vector2(0, fall_speed)

func _on_visibility_notifier_2d_screen_exited():
	# Queue free when the block goes off-screen
	queue_free()
