extends enemy

@export var speed = 400
@export var accel = 7
@export var damage = 10

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var target_body: plant
@onready var direction: Vector2

func set_target(target: plant):
	target_body = target

func _physics_process(delta):
	anim.play("run")
	if target_body == null:
		print("Enemy has no player reference!")
		pass
	else:
		direction = (target_body.global_position - global_position).normalized()
		look_at(target_body.position)
		velocity = velocity.lerp(direction * speed, accel * delta)
		move_and_slide()
