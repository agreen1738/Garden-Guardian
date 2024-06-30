extends Node2D
class_name plant



func _on_area_2d_body_entered(body):
	if body is enemy:
		body.queue_free()
