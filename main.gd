extends Sprite2D

var myCrop : int = 0
var money := 0
var onSell = false

func _ready():
	print("myCrop: ", myCrop)
	$SellArea/Label.hide()	

func _on_sell_area_has_crop():
	onSell = true
	if myCrop > 0:
		$SellArea/Label.show()
		

func _process(_delta):
	if Input.is_action_pressed("ui_e"):
		if myCrop > 0 and onSell == true:
			myCrop -= 1	
			money += 1	
			$SellArea/Label.hide()	
			$CanvasLayer/Label.text = str("Money: ", money)


func _on_crop_plot_4_crop_gathered():
	myCrop += 1
	print("myCrop updated to: ", myCrop)


func _on_crop_plot_3_crop_gathered():
	myCrop += 1
	print("myCrop updated to: ", myCrop)

func _on_crop_plot_2_crop_gathered():
	myCrop += 1
	print("myCrop updated to: ", myCrop)


func _on_crop_plot_1_crop_gathered():
	myCrop += 1
	print("myCrop updated to: ", myCrop)
