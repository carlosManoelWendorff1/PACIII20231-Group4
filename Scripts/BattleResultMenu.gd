
extends Node

func _on_ContinueButton_pressed():
	SceneTransition.change_scene("res://Scenes/SecondStage.tscn")
	
func _ready():
	var continue_button = get_node("VBoxContainer/ContinueButton")
	continue_button.grab_focus()
	
