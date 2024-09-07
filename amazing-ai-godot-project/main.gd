extends Node2D  # This extends the Node2D class (the base class for 2D nodes)
class_name Obstacle
# Variables
var score = 0
var spawn_rate = 1.0  # Time between spawns
var min_spawn_x = 0
var max_spawn_x = 1000

# Declare nodes
@onready var score_label = $ScoreLabel  # Reference to the score label
@onready var game_over_container = $Control/VBoxContainer
#@onready var final_score_label = $Control/VBoxContainer/Label[1]  # The second label in the VBoxContainer
@onready var spawn_timer = $Timer
@onready var player = $Player
@export var block_scene : PackedScene

# Called when the node enters the scene tree for the first time
func _ready():
	$Timer.wait_time = spawn_rate
	$Timer.start()
	
func _on_Timer_timeout():
	spawn_obstacle()

func spawn_obstacle():
	var block = block_scene.instantiate()
	var random_x = randf_range(min_spawn_x, max_spawn_x)
	
	block.position = Vector2(random_x, 0)
	add_child(block)

# Updates the score over time
func update_score(delta):
	score += delta
	score_label.text = "Score: " + str(int(score))  # Update the score label

# Checks if the player collides with an obstacle
func player_is_hit():
	for child in get_children():
		if child is Obstacle and player.get_collision_shape().collides_with(child.get_collision_shape()):
			return true
	return false

# Handles the game over state
func game_over():
	print("Game Over! Your score is: ", int(score))
	#final_score_label.text = "Final Score: " + str(int(score))
	game_over_container.visible = true  # Show the Game Over UI
	get_tree().paused = true  # Pause the game

# Restart the game when the button is pressed
func _on_RestartButton_pressed():
	get_tree().reload_current_scene()  # Restart the scene
