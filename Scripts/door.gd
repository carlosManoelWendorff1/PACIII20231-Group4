extends Node2D

func _on_AreaPorta_area_entered(area):
	SceneTransition.change_scene("res://Scenes/secondStage.tscn")
	
	print("colidiu com a porta") # Replace with function body.
