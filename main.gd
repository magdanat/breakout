extends Node2D

signal release

@export var ball_scene: PackedScene
var score = 0
var lives = 0
var ball

# Called when the node enters the scene tree for the first time.
func _ready():
	start_game() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_game():
	# should create a new ball and attach it to the paddle
	spawn_ball(false)
	# should spawn all the blocks

func spawn_ball(upgrade):
	ball = ball_scene.instantiate()
	ball.upgrade = upgrade
	add_child(ball)
