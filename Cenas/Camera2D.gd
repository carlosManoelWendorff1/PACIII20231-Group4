extends Camera2D

func _process(delta):
	if KinematicBody2D.get_node():
		set_position(target.global_position)
