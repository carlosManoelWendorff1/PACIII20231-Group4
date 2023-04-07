extends CanvasLayer

func change_scene(scene:String) -> void:
	$AnimationPlayer.play("dissolve")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene(scene)
	$AnimationPlayer.play_backwards("dissolve")
