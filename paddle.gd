extends CharacterBody2D

var speed = 400

func _ready():
	var screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, screen_size.y - 50)

func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	move_and_collide(velocity * delta)
