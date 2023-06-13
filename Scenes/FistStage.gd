extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	var next_phase = "res://Scenes/SecondStage.tscn"
	var enemy = "ogre"
	file.open("user://global.txt", File.WRITE)
	file.store_var(next_phase)
	file.close()
	file.store_var(enemy)
	file.close()  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
