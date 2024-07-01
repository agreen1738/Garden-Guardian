extends Area2D

class_name CropPlot
signal crop_gathered

@export var index : int

const STAGE_NO_SEED = 1
const STAGE_SEEDLING = 2
const STAGE_YOUNG_PLANT = 3
const STAGE_MATURE_PLANT = 4

var currentStage = STAGE_NO_SEED
var farmer_present = false
@onready var anim2 = $AnimatedSprite2D
@onready var anim : AnimationPlayer = $AnimationPlayer

func _ready():
	
	if currentStage == 1:
		currentStage = STAGE_NO_SEED
	elif currentStage == 2:
		currentStage = STAGE_SEEDLING
	elif currentStage == 3:
		currentStage = STAGE_YOUNG_PLANT
	elif currentStage == 4:
		currentStage = STAGE_MATURE_PLANT
	startGrowth()
	$grabTimer.start()
	updateCropAppearance()

func _process(delta):
	if currentStage == STAGE_MATURE_PLANT:
		$Mark.show()
		anim.play("Crops Ready")
	else:
		$Mark.hide()

func _on_grab_timer_timeout():
	if farmer_present:
		emit_signal("crop_gathered")
		currentStage = STAGE_NO_SEED
		updateCropAppearance()
		return true

func startGrowth():
	$growthTimer.start()

func _on_growth_timer_timeout():
	match currentStage:
		STAGE_NO_SEED:
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
			startGrowth()
		STAGE_SEEDLING:
			$stage1.show()
			$stage2.hide()
			$stage3.hide()
			startGrowth()
		STAGE_YOUNG_PLANT:
			$stage1.hide()
			$stage2.show()
			$stage3.hide()
			startGrowth()
		STAGE_MATURE_PLANT:
			$stage1.hide()
			$stage2.hide()
			$stage3.show()

func _on_body_entered(body):
	var mySeed = get_parent()
	if body.is_in_group("Farmer") and currentStage == STAGE_MATURE_PLANT:
			print("Gathering")
			farmer_present = true
			$grabTimer.start()

func _on_body_exited(body):
	if body.is_in_group("Farmer"):
		farmer_present = false
		$grabTimer.stop()
