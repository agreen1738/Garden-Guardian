extends Sprite2D

var myCrop: int = 0
var money := 0

func _ready():
	print("myCrop: ", myCrop)
	$SellArea/Label.hide()

func _on_crop_plot_crop_gathered():
	myCrop = 1
	print("myCrop updated to: ", myCrop)

func _on_sell_area_has_crop():
	if myCrop == 1:
		$SellArea/Label.show()
		

func _process(delta):
		if myCrop == 1 and Input.is_action_pressed("ui_select"):
			myCrop = 0
			money += 1
			$CanvasLayer/Label.text = str("Money: ", money)
