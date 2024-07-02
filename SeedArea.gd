extends Area2D

signal get_seed
var farmer_present = false

func _ready():
	$checkSeed.start()


func _on_check_seed_timeout():
	if farmer_present:
		emit_signal("get_seed")
		return true

func _on_body_entered(body):
	if body.is_in_group("Farmer"):
		farmer_present = true
		$checkSeed.start()

func _on_body_exited(body):
	if body.is_in_group("Farmer"):
		farmer_present = false
		$Label.hide()
		$checkSeed.stop()
