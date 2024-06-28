extends CharacterBody2D

const MOVE_SPEED = 200  # Adjust movement speed as needed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Initialization code goes here

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Example: Handle input to move the Farmer
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	# Normalize velocity to ensure diagonal movement isn't faster
	velocity = velocity.normalized() * MOVE_SPEED
	move_and_collide(velocity * delta)
