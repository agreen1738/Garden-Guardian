extends Sprite2D

var myCrop : int = 0
var money := 0
var onSell = false

func _ready():
	print("myCrop: ", myCrop)
	$SellArea/Label.hide()

func _on_crop_plot_crop_gathered():
	myCrop = 1
	print("myCrop updated to: ", myCrop)
	

func _on_sell_area_has_crop():
	onSell = true
	if myCrop == 1:
		$SellArea/Label.show()
		

func _process(delta):
	if Input.is_action_pressed("ui_select"):
		if myCrop == 1 and onSell == true:
			myCrop = 0	
			money += 1	
			$SellArea/Label.hide()	
			$CanvasLayer/Label.text = str("Money: ", money)
