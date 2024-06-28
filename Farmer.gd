extends CharacterBody2D

const SPEED = 300.0
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
	x_move()
	y_move()
	position.x = clamp(position.x, p_width / 2, win_width - p_width / 2)
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)

func x_move():
	var direction_x = Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
		
func y_move():
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
