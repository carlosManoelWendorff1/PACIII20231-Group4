extends Camera2D

@export var target : CharacterBody2D

func _process(delta):
	if target:
		set_position(target.global_position)
