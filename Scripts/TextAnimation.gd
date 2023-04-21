extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TweenLabelSpace.interpolate_property(self, "percent_visible",0.0,1.0,3.0,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	$TweenLabelSpace.start()

	$Label2Space/TweenLabelSpace2.interpolate_property($Label2Space,"visible",true,false,0.5,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT)
	$Label2Space/TweenLabelSpace2.repeat = true
	$Label2Space/TweenLabelSpace2.start()
	$Label2Space/TweenLabelSpace21.interpolate_property($Label2Space,"rect_position:x",4,234,3.0,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	$Label2Space/TweenLabelSpace21.start()

