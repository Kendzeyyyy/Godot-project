extends Node2D  # This extends the Node2D class (the base class for 2D nodes)

# Variables
var score = 0
var spawn_rate = 1.0  # Time between spawns
var min_spawn_x = 0
var max_spawn_x = 1000

# Declare nodes
@export var block_scene : PackedScene
@onready var score_label = $Control/Label  # Reference to the score label
@onready var game_over_container = $Control/VBoxContainer
#@onready var final_score_label = $Control/VBoxContainer/Label[1]  # The second label in the VBoxContainer
@onready var spawn_timer = $Timer
@onready var player = $Player

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
