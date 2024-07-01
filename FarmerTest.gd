extends CharacterBody2D

@export var starting_direction : Vector2 = Vector2(0,1)
@export var move_speed : float = 250  # Adjust movement speed as needed

var p_height : float
var win_height: float
var p_width : float
var win_width : float


@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	update_animation_parameters(starting_direction)
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y

	win_width = get_viewport_rect().size.x
	p_width = $ColorRect.get_size().x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x = clamp(position.x, -539, 556)
	position.y = clamp(position.y, -280, 280)
	var input_direction = Vector2(
	Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
	Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	update_animation_parameters(input_direction)
	
	velocity = input_direction * move_speed
	
	move_and_slide()
	pick_new_state()



func update_animation_parameters(move_input : Vector2):
	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
