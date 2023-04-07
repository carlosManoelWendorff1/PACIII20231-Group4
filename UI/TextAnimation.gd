extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TweenLabel.interpolate_property(self, "percent_visible",0.0,1.0,3.0,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	$TweenLabel.start()
	$Label2/TweenLabel2.interpolate_property($Label2,"visible",true,false,0.5,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT)
	$Label2/TweenLabel2.repeat = true
	$Label2/TweenLabel2.start()
#func _process(delta):
#	pass
