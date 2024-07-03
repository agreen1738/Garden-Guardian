extends State
class_name EnemyAttackPlayer

@export var move_speed := 100.0

var farmer: Farmer
var direction: Vector2
var parent

func _ready():
	farmer = initializer.farmer
	parent = initializer.parent

func Enter():
	parent = initializer.parent
	
func Update(delta: float):
	if initializer.farmer:
		farmer = initializer.farmer
	if initializer.parent:
		parent = initializer.parent
	
func Physics_Update(delta: float):
	if initializer.farmer and initializer.parent and initializer.nav:
		#direction = initializer.farmer.global_position - initializer.parent.global_position
		#initializer.parent.velocity = direction.normalized()
		
		initializer.nav.target_position = initializer.parent.position
		direction = (initializer.nav.get_next_path_position() - global_position).normalized()
		initializer.parent.velocity = initializer.parent.velocity.lerp(direction * initializer.speed, initializer.accel * delta)
