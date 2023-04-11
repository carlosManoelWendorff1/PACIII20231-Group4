extends Camera2D

func _process(delta):
	if CharacterBody2D.:
		set_position(target.global_position)
