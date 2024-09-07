extends Node2D  # This extends the Node2D class (the base class for 2D nodes)
class_name Obstacle
# Variables
var score = 0
var spawn_rate = 1.0  # Time between spawns

# Declare nodes
@onready var score_label = $ScoreLabel  # Reference to the score label
@onready var game_over_container = $Control/VBoxContainer
#@onready var final_score_label = $Control/VBoxContainer/Label[1]  # The second label in the VBoxContainer
@onready var spawn_timer = $Timer
@onready var player = $Player

# Called when the node enters the scene tree for the first time
func _ready():
	spawn_timer.start(spawn_rate)

# Called every frame, handles score updates and game logic
func _process(delta):
	update_score(delta)
	if player_is_hit():
		game_over()

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
