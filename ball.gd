extends RigidBody2D

@export var upgrade : bool

var collision_coords : Vector2
var velocity : Vector2
var rng = RandomNumberGenerator.new()
var released : bool
var paddle : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# If a ball spawns, it should either be because of the following conditions:
	# 1. It's the start of the game
	# 2. The paddle hit a multiplier upgrade
	#    a. If it's from an upgrade, 
	# 3. The previous ball died and the player still has remaining lives
	
	# Should be given the same velocity of the original ball but in a different direction
	if upgrade:
		released = true
	else:
		released = false
		paddle = get_parent().get_node("Paddle")
		velocity = Vector2(0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if !released:
		position = Vector2(paddle.position.x + paddle.get_node("CollisionShape2D").shape.size.x / 2, paddle.position.y - get_node("CollisionShape2D").shape.radius)
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		collision_coords = Vector2(position.x, position.y)
		if (collider.is_in_group("Paddles")):
			var paddlePos = collider.position
			var relativeBallPosition = collision_coords - paddlePos
			velocity = relativeBallPosition.normalized() * rng.randf_range(600, 600)
			move_and_collide(velocity * delta)
		else:
			var collision_normal = collision.get_normal()
			var reflect = collision.get_remainder().bounce(collision_normal)
			velocity = velocity.bounce(collision_normal)
			move_and_collide(reflect)

func _input(event):
	if event.is_action_pressed("release"):
		released = true
		velocity = Vector2(rng.randf_range(-100, 100), -200)

