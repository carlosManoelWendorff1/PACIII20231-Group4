extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property(self,"visible",true,false,1,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT)
	$Tween.repeat = true
	$Tween.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
