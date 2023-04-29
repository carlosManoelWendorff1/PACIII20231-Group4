extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$GobackButton.grab_focus();
	$"W-Key/AnimationPlayer".play("Nova Animação")
	$"Space-Key/AnimationPlayer".play("SpaceAnimation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GobackButton_pressed():
	get_tree().change_scene("res://Scenes/Settings menu.tscn")
