extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lastValue = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print(lastValue)
	$GobackButton.grab_focus();
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),lastValue)
	$"W-Key/AnimationPlayer".play("Nova Animação")


	
func _on_GoBackButton_pressed():
	get_tree().change_scene("res://UI/Menu.tscn")
	pass # Replace with function body.


func _on_CheckButton_pressed():
		OS.window_fullscreen = !OS.window_fullscreen


func _on_HSlider_value_changed(value):
	lastValue = value
	print(lastValue)
	print(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value )



func _on_ControlsButton_pressed():
	get_tree().change_scene("res://Scenes/Controls.tscn")

