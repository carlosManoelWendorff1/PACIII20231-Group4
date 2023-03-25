extends Camera2D

func _process(delta):
	if KinematicBody2D.:
		set_position(target.global_position)
