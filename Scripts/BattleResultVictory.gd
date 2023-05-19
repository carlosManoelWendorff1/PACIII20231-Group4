extends Node

onready var title = $VBoxContainer2/CenterContainer/Label
var next_phase = "res://UI/Menu.tscn"

func set_title(win: bool):
	if win:
		title.text = "Victory Achieved!"
		title.modulate = Color.green
	else:
		title.text = "Defeat!"
		title.modulate = Color.red

func _on_ContinueButton_pressed():
	SceneTransition.change_scene(next_phase)
	
func _ready():
	var continue_button = get_node("VBoxContainer/ContinueButton")
	set_title(true)
	continue_button.grab_focus()
	var file = File.new()
	if file.file_exists("user://global.txt"):
		file.open("user://global.txt", File.READ)
		next_phase = file.get_var()
		file.close()
