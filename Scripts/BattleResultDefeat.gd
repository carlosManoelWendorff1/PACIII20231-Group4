extends Node

onready var title = $VBoxContainer2/CenterContainer/Label

func set_title(win: bool):
	if win:
		title.text = "Victory Achieved!"
		title.modulate = Color.green
	else:
		title.text = "Defeat!"
		title.modulate = Color.red

func _on_ContinueButton_pressed():
	SceneTransition.change_scene("res://Scenes/SecondStage.tscn")
	
func _ready():
	var continue_button = get_node("VBoxContainer/ContinueButton")
	set_title(false)
	continue_button.grab_focus()
