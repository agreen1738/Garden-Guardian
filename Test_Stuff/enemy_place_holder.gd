extends CharacterBody2D
class_name enemy

var target: Vector2

func _physics_process(delta):
	velocity = (target - position)
	velocity = velocity.normalized() * 300
	move_and_slide()

func set_target(t):
	target = t
