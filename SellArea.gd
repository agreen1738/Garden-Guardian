extends Area2D

signal has_crop
var farmer_present = false

func _ready():
	$checkBox.start()

func _on_check_box_timeout():
	if farmer_present:
		emit_signal("has_crop")
		return true

func _on_body_entered(body):
	if body.is_in_group("Farmer"):
		farmer_present = true
		$checkBox.start()


func _on_body_exited(body):
	if body.is_in_group("Farmer"):
		farmer_present = false
		$Label.hide()
		$checkBox.stop()

