extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var PlayButton:Button
var countFarClouds = 0
var isReverseFarClouds = false
var countCloseClouds = 0
var isReverseCloseClouds = false


func _ready():
	PlayButton = get_node("VBoxContainer/PlayButton")
	PlayButton.grab_focus()
	$ParallaxBackground/Sky.set_scale(Vector2(5,5))
	

func _process(delta):
	$ParallaxBackground/FarClounds.set_transform(Transform2D(0.0,Vector2(self.countFarClouds,0)))
	if $ParallaxBackground/FarClounds.get_position() < Vector2(-250,0):
		isReverseFarClouds = true
	if $ParallaxBackground/FarClounds.get_position() > Vector2(0,0):
		isReverseFarClouds = false
		
	if !isReverseFarClouds:
		countFarClouds -=0.02;
	elif isReverseFarClouds:
		countFarClouds +=0.02;
		
	$ParallaxBackground/closeClouds.set_transform(Transform2D(0.0,Vector2(self.countCloseClouds,0)))
	if $ParallaxBackground/closeClouds.get_position() < Vector2(-250,0):
		isReverseCloseClouds = true
	if $ParallaxBackground/closeClouds.get_position() > Vector2(0,0):
		isReverseCloseClouds = false
		
	if !isReverseCloseClouds:
		countCloseClouds -=0.04;
	elif isReverseCloseClouds:
		countCloseClouds +=0.04;
	


func _on_QuitButton_pressed():
	print("Quit Pressed")
	get_tree().quit()
	pass # Replace with function body.


func _on_PlayButton_pressed():
	print("Play Pressed")
	SceneTransition.change_scene("res://Scenes/FistStage.tscn")
	pass # Replace with function body.


func _on_PlayButton_focus_entered():
	var button = get_node("VBoxContainer/PlayButton")
	pass # Replace with function body.


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Scenes/Settings menu.tscn")
	pass # Replace with function body.
