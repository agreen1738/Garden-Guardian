extends Node2D
class_name spawner

var enemy_array

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_array = get_meta("Enemies")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## Spawns the first element element in resources. Prelim implementation; will hopefully handle more than one 'enemy'
func spawn(target):
	var enemy_mob = enemy_array[0].instantiate()
	enemy_mob.global_position = global_position
	if enemy_mob is enemy:
		enemy_mob.set_target(target)
	get_parent().add_child(enemy_mob)
	print("Spawn something")
