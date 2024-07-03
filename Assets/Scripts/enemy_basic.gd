extends enemy

@export var speed = 250
@export var accel = 7
@export var damage = 10

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var target_body: plant
@onready var direction: Vector2
@onready var state_machine: State_Machine = $State_Machine

var initializer: State_Initializer
var targets := []

func _ready():
	initializer = State_Initializer.new()
	initializer.parent = self
	for n in get_parent().get_children():
		if n is CropPlot:
			initializer.crops.append(n)
		if n is Farmer:
			initializer.farmer = n
	state_machine.initializer = initializer
			

func _physics_process(delta):
	move_and_slide()
	
	if velocity.length() > 0:
		anim.play("run")
	
	if velocity.x > 0:
		anim.flip_h = true
	else:
		anim.flip_h = false

func set_target(target: plant):
	target_body = target
	
	
#
#func _physics_process(delta):
	#anim.play("run")
	#if target_body == null:
		#print("Enemy has no player reference!")
		#pass
	#else:
		#if not is_target_to_the_left():
			#anim.flip_h = true
		#direction = (target_body.global_position - global_position).normalized()
		#velocity = velocity.lerp(direction * speed, accel * delta)
		#move_and_slide()
#
#func is_target_to_the_left():
	#return target_body.position.x < position.x
