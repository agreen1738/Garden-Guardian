extends Node2D

## Rate at which spawn occurs per second. Basically, smaller value is slower and bigger value is faster.
@export_range(0.0, 5.0) var spawn_rate = 0.5
@onready var timer_spawn = $timer_spawn

var targets_array := []
var spawner_array := []

# Called when the node enters the scene tree for the first time.
func _ready():
	timer_spawn.wait_time = 1 / spawn_rate
	timer_spawn.start()
	var siblings = get_parent().get_children()
	for node in siblings:
		if node is spawner:
			spawner_array.append(node)
		if node is plant:
			targets_array.append(node)
func spawn():
	spawner_array.pick_random().spawn(targets_array.pick_random())

func _on_timer_spawn_timeout():
	spawn()
