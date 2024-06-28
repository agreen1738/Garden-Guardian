extends Area2D

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
	print("CropPlot ready")
	$grabTimer.start()

# Function to be called when the Timer times out
func _on_grab_timer_timeout():
	if farmer_present:
		print("Gathered Plant")  # Print message indicating plant gathered
	else:
		print("Timer timed out but Farmer not present")

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
		STAGE_MATURE_PLANT:
			$growthTimer.stop()
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

func _on_body_entered(body):
	if body.is_in_group("Farmer"):
		print("Farmer entered CropPlot")
		farmer_present = true
		$grabTimer.start()  # Start or restart the timer when Farmer enters
	else:
		print("Body entered: ", body.name)

# Function called when a body exits the CropPlot's area.
func _on_body_exited(body):
	if body.is_in_group("Farmer"):
		print("Farmer exited CropPlot")
		farmer_present = false
		$grabTimer.stop()  # Stop the timer if the Farmer leaves before 3 seconds
	else:
		print("Body exited: ", body.name)
