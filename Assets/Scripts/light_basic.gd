extends PointLight2D
@export var flicker_length = 1.0
var time_between_flickers
var start_scale

@onready var timer_flicker: Timer = $Timer_Flicker
var texture_scale_: float
var flicker: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	time_between_flickers = timer_flicker.wait_time
	start_scale = texture_scale
	texture_scale_ = texture_scale
	timer_flicker.start()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flicker:
		var flicker_offset_scale = randf_range(.5, .75)
		texture_scale = texture_scale_ * flicker_offset_scale

func _on_timer_flicker_timeout():
	if not flicker:
		flicker = true
		timer_flicker.wait_time = flicker_length * randf_range(0, 2)
		timer_flicker.start()
	else:
		flicker = false
		texture_scale = start_scale
		timer_flicker.wait_time = time_between_flickers * randf_range(0, 2)
		timer_flicker.start()

