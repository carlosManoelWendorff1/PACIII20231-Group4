extends Node2D

func _on_AreaPorta_area_entered(area):
	SceneTransition.change_scene_to_file("res://Scenes/SecondStage.tscn")
	
	print("colidiu com a porta") # Replace with function body.
