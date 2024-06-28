extends Node2D
@onready var plant = $Plant_Place_Holder
@onready var timer_spawn: Timer = $Timer_Spawn

var spawner_array := []

func _ready():
	timer_spawn.start()

func _on_child_entered_tree(node):
	if node is spawner:
		spawner_array.append(node)

#
#func _on_timer_spawn_timeout():
	#spawner_array.pick_random().spawn(plant)
