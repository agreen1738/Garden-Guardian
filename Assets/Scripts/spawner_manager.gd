extends Node2D

var targets_array := []
var spawner_array := []

@onready var timer_spawn = $timer_spawn

# Called when the node enters the scene tree for the first time.
func _ready():
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
