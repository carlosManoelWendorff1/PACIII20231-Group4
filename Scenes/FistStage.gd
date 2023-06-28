extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	var next_phase = "res://Scenes/SecondStage.tscn"
	file.open("user://global.txt", File.WRITE)
	file.store_var(next_phase)
	
	var tutorial_file = File.new()
	tutorial_file.open("user://tutorial.txt", File.WRITE)
	tutorial_file.store_string("false")
	tutorial_file.close()
	$popup.show_popup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
