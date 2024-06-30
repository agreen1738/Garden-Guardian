extends Area2D

signal crop_gathered

const STAGE_SEEDLING = 1
const STAGE_YOUNG_PLANT = 2
const STAGE_MATURE_PLANT = 3

var currentStage = STAGE_SEEDLING
var sprite
var farmer_present = false

func _ready():
	print("ready")
	sprite = $ColorRect
	startGrowth()
	$grabTimer.start()

func _on_grab_timer_timeout():
	if farmer_present:
		emit_signal("crop_gathered")
		return true

func startGrowth():
	$growthTimer.start()
	print("End of startGrowth")

func _on_growth_timer_timeout():
	match currentStage:
		STAGE_SEEDLING:
			currentStage = STAGE_YOUNG_PLANT
			updateCropAppearance()
		STAGE_YOUNG_PLANT:
			currentStage = STAGE_MATURE_PLANT
			updateCropAppearance()
		STAGE_MATURE_PLANT:
			$growthTimer.stop()

func updateCropAppearance():
	match currentStage:
		STAGE_SEEDLING:
			sprite.modulate = Color(0.5, 0.8, 0.5)
			startGrowth()
		STAGE_YOUNG_PLANT:
			sprite.modulate = Color(0.7, 0.9, 0.7)
			startGrowth()
		STAGE_MATURE_PLANT:
			sprite.modulate = Color(0.3, 0.6, 0.3)

func _on_body_entered(body):
	if body.is_in_group("Farmer") and currentStage == STAGE_MATURE_PLANT:
		print("Farmer entered CropPlot")
		farmer_present = true
		$grabTimer.start()

func _on_body_exited(body):
	if body.is_in_group("Farmer"):
		print("Farmer exited CropPlot")
		farmer_present = false
		$grabTimer.stop()
