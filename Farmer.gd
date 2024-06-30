extends CharacterBody2D

const MOVE_SPEED = 250  # Adjust movement speed as needed
var p_height : int
var win_height: int
var p_width : int
var win_width : int

# Called when the node enters the scene tree for the first time.
func _ready():
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y

	win_width = get_viewport_rect().size.x
	p_width = $ColorRect.get_size().x
	
func _physics_process(delta):
	position.x = clamp(position.x, p_width / 2, win_width - p_width / 2)
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
	
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
