extends StaticBody2D

const STAGE_SEEDLING = 1
const STAGE_YOUNG_PLANT = 2
const STAGE_MATURE_PLANT = 3

var currentStage = STAGE_SEEDLING
var sprite

func _ready():
	sprite = $ColorRect
	startGrowth()

func startGrowth():
	$growthTimer.start()  # Start the growth timer
	print("End of startGrowth")

func _on_growth_timer_timeout():
	print("in ogtt")
	match currentStage:
		STAGE_SEEDLING:
			currentStage = STAGE_YOUNG_PLANT
			updateCropAppearance()

		STAGE_YOUNG_PLANT:
			currentStage = STAGE_MATURE_PLANT
			updateCropAppearance()
			# No further growth stages needed for now
	print("end of ogtt")

func updateCropAppearance():
	print("Crop grew to stage:", currentStage)
	match currentStage:
		STAGE_SEEDLING:
			sprite.modulate = Color(0.5, 0.8, 0.5)  # Example: Greenish color
			startGrowth()

		STAGE_YOUNG_PLANT:
			sprite.modulate = Color(0.7, 0.9, 0.7)  # Example: Lighter green color
			startGrowth()

		STAGE_MATURE_PLANT:
			sprite.modulate = Color(0.3, 0.6, 0.3)  # Example: Darker green color
			print("done growing")
