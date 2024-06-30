extends Area2D

signal crop_gathered

const STAGE_NO_SEED = 1
const STAGE_SEEDLING = 2
const STAGE_YOUNG_PLANT = 3
const STAGE_MATURE_PLANT = 4

var currentStage = STAGE_SEEDLING
var sprite
var farmer_present = false

func _ready():
	print("ready")
	startGrowth()
	$grabTimer.start()
	updateCropAppearance()

func _on_grab_timer_timeout():
	if farmer_present:
		emit_signal("crop_gathered")
		currentStage = STAGE_NO_SEED
		updateCropAppearance()
		return true

func startGrowth():
	$growthTimer.start()
	print("End of startGrowth")

func _on_growth_timer_timeout():
	match currentStage:
		STAGE_NO_SEED:
			#currentStage = STAGE_SEEDLING
			updateCropAppearance()
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
		STAGE_NO_SEED:
			$emptyCrop.show()
			$stage1.hide()
			$stage2.hide()
			$stage3.hide()
			print("in noseed")
			startGrowth()
		STAGE_SEEDLING:
			$stage1.show()
			$stage2.hide()
			$stage3.hide()
			print("in seedling")
			startGrowth()
		STAGE_YOUNG_PLANT:
			$stage1.hide()
			$stage2.show()
			$stage3.hide()
			print("in young")
			startGrowth()
		STAGE_MATURE_PLANT:
			$stage1.hide()
			$stage2.hide()
			$stage3.show()
			print("in mature")

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
