extends Area2D

func _on_Area2D_area_entered(area):
	if Input.is_action_pressed("ui_accept"):
		print("kkkk")
	print("encstou {}",area) # Replace with function body.

func _on_Area2D_area_exited(area):
	if Input.is_action_pressed("ui_accept"):
		print("kkkk")
	print("desencostou {}",area) # Replace with function body.
