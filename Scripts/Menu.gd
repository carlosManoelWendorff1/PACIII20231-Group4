extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var PlayButton:Button

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayButton = get_node("VBoxContainer/PlayButton")
	PlayButton.grab_focus()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
