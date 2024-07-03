extends Sprite2D

var myCrop : int = 0
var mySeed : int = 0
var money := 0
var onSell = false
var onSeed = false

var isinPlot1 = false
var isinPlot2 = false
var isinPlot3 = false
var isinPlot4 = false

var cropPlot1
var cropPlot2
var cropPlot3
var cropPlot4

var truck
var anim

func _ready():
	truck = get_node("Truck/AnimatedSprite2D")
	anim = $Truck/AnimatedSprite2D
	cropPlot1 = get_node("CropPlot1")
	cropPlot2 = get_node("CropPlot2")
	cropPlot3 = get_node("CropPlot3")
	cropPlot4 = get_node("CropPlot4")
	
	truck.play("Highlight")
	
	$SellArea/Label.hide()
	$SeedArea/Label.hide()

func _physics(_delta):
	
	var onSell = false
	var onSeed = false

func _on_sell_area_has_crop():
	onSell = true
	#if myCrop > 0:
		#

func _on_seed_area_get_seed():
	onSeed = true
	$SeedArea/Label.show()

func _process(_delta):
	if Input.is_action_pressed("ui_e") and mySeed < 4 and onSeed == true:
		mySeed += 1
		$SeedArea/Label.hide()
		$CanvasLayer/Seed.text = str("Seed: ", mySeed)    
	
	if Input.is_action_pressed("ui_e") and myCrop > 0 and onSell == true:
		myCrop -= 1    
		money += 1    
		$SellArea/Label.hide()    
		$CanvasLayer/Money.text = str("Money: ", money)
		$CanvasLayer/Crops.text = str("Crops: ", myCrop)

func _on_crop_plot_4_crop_gathered():
	myCrop += 1
	$CanvasLayer/Crops.text = str("Crops: ", myCrop)

func _on_crop_plot_3_crop_gathered():
	myCrop += 1
	$CanvasLayer/Crops.text = str("Crops: ", myCrop)

func _on_crop_plot_2_crop_gathered():
	myCrop += 1
	$CanvasLayer/Crops.text = str("Crops: ", myCrop)

func _on_crop_plot_1_crop_gathered():
	myCrop += 1
	$CanvasLayer/Crops.text = str("Crops: ", myCrop)

func _input(event):	
	if isinPlot4 and event.is_action_pressed("ui_e") and mySeed > 0 and cropPlot4.currentStage == 0:
		mySeed -= 1
		cropPlot4.currentStage = 1
		$CanvasLayer/Seed.text = str("Seed: ", mySeed)
		
	if isinPlot3 and event.is_action_pressed("ui_e") and mySeed > 0 and cropPlot3.currentStage == 0:
		mySeed -= 1
		cropPlot3.currentStage = 1
		$CanvasLayer/Seed.text = str("Seed: ", mySeed)
		
	if isinPlot2 and event.is_action_pressed("ui_e") and mySeed > 0 and cropPlot2.currentStage == 0:
		mySeed -= 1
		cropPlot2.currentStage = 1
		$CanvasLayer/Seed.text = str("Seed: ", mySeed)
		
	if isinPlot1 and event.is_action_pressed("ui_e") and mySeed > 0 and cropPlot1.currentStage == 0:
		mySeed -= 1
		cropPlot1.currentStage = 1
		$CanvasLayer/Seed.text = str("Seed: ", mySeed)
		


func _on_sell_area_body_exited(body):
	onSell = false

func _on_crop_plot_4_body_entered(body):
	isinPlot4 = true
	onSeed = false
func _on_crop_plot_4_body_exited(body):
	isinPlot4 = false

func _on_crop_plot_3_body_entered(body):
	isinPlot3 = true
	onSeed = false
func _on_crop_plot_3_body_exited(body):
	isinPlot3 = false

func _on_crop_plot_2_body_entered(body):
	isinPlot2 = true
	onSeed = false
func _on_crop_plot_2_body_exited(body):
	isinPlot2 = false

func _on_crop_plot_1_body_entered(body):
	isinPlot1 = true
	onSeed = false
func _on_crop_plot_1_body_exited(body):
	isinPlot1 = false


