extends Node2D  # This extends the Node2D class (the base class for 2D nodes)
class_name Obstacle
# Variables
var score = 0
var spawn_rate = 0.5  # Time between spawns
var min_spawn_x = 0
var max_spawn_x = 1000

# Declare nodes
@onready var score_label = $ScoreLabel  # Reference to the score label
#@onready var game_over_container = $Control/VBoxContainer
#@onready var final_score_label = $Control/VBoxContainer/Label[1]  # The second label in the VBoxContainer
@onready var spawn_timer = $Timer
@onready var player = $Player
@export var block_scene : PackedScene

# Called when the node enters the scene tree for the first time
func _ready():
	$Timer.wait_time = spawn_rate
	$Timer.start()
	var music_player = $AudioStreamPlayer  # Adjust this path if your AudioStreamPlayer node is elsewhere
	music_player.play()  # Play the background music when the scene starts
	
func _process(delta):
	update_score(delta)
	
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

# Restart the game when the button is pressed
func _on_RestartButton_pressed():
	get_tree().reload_current_scene()  # Restart the scene
