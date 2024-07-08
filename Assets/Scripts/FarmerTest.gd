extends CharacterBody2D

@export var starting_direction : Vector2 = Vector2(0,1)
@export var move_speed : float = 250

var PlayerHealth = 3
var input_direction

var cropPlot1
var cropPlot2
var cropPlot3
var cropPlot4

@onready var anim = $AnimatedSprite2D
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	$Bat.remove_from_group("Farmer")
	$Bat.hide()
	$Bat.disabled = true
	cropPlot1 = get_parent().get_node("CropPlot1")
	cropPlot2 = get_parent().get_node("CropPlot2")
	cropPlot3 = get_parent().get_node("CropPlot3")
	cropPlot4 = get_parent().get_node("CropPlot4")
	anim.hide()
	update_animation_parameters(starting_direction)

func _on_anim_timer_timeout():
	$Bat.hide()
	anim.hide()
	$Sprite2D.show()
	$Bat.disabled = true

func _physics_process(_delta):
	input_direction = Vector2(
	Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
	Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)	
	update_animation_parameters(input_direction)
	
	velocity = input_direction * move_speed

	move_and_slide()
	pick_new_state()

func _input(event):
	if Input.is_action_pressed("ui_select"):
		var current_state = state_machine.get_current_node()
		if current_state == "Idle" and animation_tree.get("parameters/Idle/blend_position") == Vector2(0, 1):
			anim.show()
			$Bat.show()
			$Sprite2D.hide()
			$AnimTimer.start()
			$Bat.disabled = false
			anim.play("Swing Down")
		if current_state == "Walk" and animation_tree.get("parameters/Idle/blend_position") == Vector2(0, 1):
			anim.show()
			$Bat.show()
			$Sprite2D.hide()
			$AnimTimer.start()
			$Bat.disabled = false
			anim.play("Swing Down")
		if current_state == "Idle" and animation_tree.get("parameters/Idle/blend_position") == Vector2(0, -1):
			anim.show()
			$Bat.show()
			$Sprite2D.hide()
			$AnimTimer.start()
			anim.play("Swing Up")
		if current_state == "Walk" and animation_tree.get("parameters/Idle/blend_position") == Vector2(0, -1):
			anim.show()
			$Bat.show()
			$Sprite2D.hide()
			$AnimTimer.start()
			$Bat.disabled = false
			anim.play("Swing Up")
		if current_state == "Idle" and animation_tree.get("parameters/Idle/blend_position") == Vector2(1, 0):
			anim.show()
			$Bat.show()
			$Sprite2D.hide()
			$AnimTimer.start()
			$Bat.disabled = false
			anim.play("Swing Right")
		if current_state == "Walk" and animation_tree.get("parameters/Idle/blend_position") == Vector2(1, 0):
			anim.show()
			$Bat.show()
			$Sprite2D.hide()
			$AnimTimer.start()
			$Bat.disabled = false
			anim.play("Swing Right")
		if current_state == "Idle" and animation_tree.get("parameters/Idle/blend_position") == Vector2(-1, 0):
			anim.show()
			$Bat.show()
			$Sprite2D.hide()
			$AnimTimer.start()
			$Bat.disabled = false
			anim.play("Swing Left")
		if current_state == "Walk" and animation_tree.get("parameters/Idle/blend_position") == Vector2(-1, 0):
			anim.show()
			$Bat.show()
			$Sprite2D.hide()
			$AnimTimer.start()
			$Bat.disabled = false
			anim.play("Swing Left")
			
func update_animation_parameters(move_input : Vector2):
	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")

func _on_crop_plot_4_body_entered(_body): 
	if cropPlot4.currentStage == 4:
		anim.show()
		$Sprite2D.hide()
		anim.play("Gather")

func _on_crop_plot_4_body_exited(_body):
	anim.hide()
	$Sprite2D.show()

func _on_crop_plot_4_crop_gathered():
	anim.hide()
	$Sprite2D.show()	

func _on_crop_plot_3_body_entered(_body):
	if cropPlot3.currentStage == 4:
		anim.show()
		$Sprite2D.hide()
		anim.play("Gather")

func _on_crop_plot_3_body_exited(_body):
	anim.hide()
	$Sprite2D.show()

func _on_crop_plot_3_crop_gathered():
	anim.hide()
	$Sprite2D.show()

func _on_crop_plot_2_body_entered(_body):
	if cropPlot2.currentStage == 4:
		anim.show()
		$Sprite2D.hide()
		anim.play("Gather")

func _on_crop_plot_2_body_exited(_body):
	anim.hide()
	$Sprite2D.show()

func _on_crop_plot_2_crop_gathered():
	anim.hide()
	$Sprite2D.show()

func _on_crop_plot_1_body_entered(_body):
	if cropPlot1.currentStage == 4:
		anim.show()
		$Sprite2D.hide()
		anim.play("Gather")

func _on_crop_plot_1_body_exited(_body):
	anim.hide()
	$Sprite2D.show()

func _on_crop_plot_1_crop_gathered():
	anim.hide()
	$Sprite2D.show()
