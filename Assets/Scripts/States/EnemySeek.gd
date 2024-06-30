extends State
class_name EnemySeek

@export var enemy_mob: CharacterBody2D
@export var move_speed := 40.0

var targets: Array
var target

func Enter():
	targets = initializer.crops
	
func Physics_Update(delta: float):
	if not target:
		target = targets.pick_random()
		
	var direction: Vector2 = target.global_position - enemy_mob.global_position
	enemy_mob.velocity = direction.normalized() * move_speed
