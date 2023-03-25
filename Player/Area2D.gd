extends Area2D

var collided_object = null

func _on_body_entered(body):
	print("collided")
	if body.name == "Wall":
		collided_object = body
		print("collided")
		# Add your code here to execute when the Area2D node collides with MyObject

func _on_body_exited(body):
	print("not collided")
	if body == collided_object:
		collided_object = null
		print("not collided")
		# Add your code here to execute when the Area2D node stops colliding with MyObject


func _on_Area2D_area_entered(area):
	print("encstou {}",area) # Replace with function body.
