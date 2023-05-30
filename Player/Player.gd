extends KinematicBody2D

onready var animation: AnimationPlayer = get_node("Sprite/Animation")

const SPEED = 10000
var motion = Vector2.ZERO
var inArea = false
export var camera_speed = 1
var actualAnimation = "iddle"

func _physics_process(delta):

	motion = Vector2.ZERO

	
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
		if Input.is_action_pressed("ui_right"):
			motion += Vector2(1, 0)
			$Sprite.flip_h = false
			animation.play("andando")
		if Input.is_action_pressed("ui_down"):
			motion += Vector2(0, 1)
			animation.play("andando")
		if Input.is_action_pressed("ui_left"):
			motion += Vector2(-1, 0)
			$Sprite.flip_h = true
			animation.play("andando")
		if Input.is_action_pressed("ui_up"):
			motion += Vector2(0, -1)
			animation.play("andando")
	else:
		animation.play("RESET")

	motion = motion.normalized() * SPEED * delta
	move_and_slide(motion)
	if(inArea):
		get_tree().change_scene("res://Scenes/DialogueContainer.tscn")
		
		

func _process(delta):
	if(Input.is_action_just_released("ui_cancel")):
		SceneTransition.change_scene("res://UI/Menu.tscn")
	
func _on_Area2DPlayer_area_exited(area):
	print("desencostou {}",area) # Replace with function body.
	inArea = false
	print(inArea)

func animate() -> void:
	if motion != Vector2.ZERO:
		animation.play("iddle")
	else:
		animation.stop()
func _on_Area2DPlayer_area_entered(area):
	print("encostou {}",area.get_instance_id())
	var aid = area.get_instance_id()
	if(aid == 1452):
		var file = File.new()
		var enemy = "skelleton"
		file.open("user://global.txt", File.WRITE)
		file.store_var(enemy)
		file.close() 
	elif(aid == 1438):
		var file = File.new()
		var enemy = "ogre"
		file.open("user://global.txt", File.WRITE)
		file.store_var(enemy)
		file.close() 
	elif(aid == 1413):
		var file = File.new()
		var enemy = "mini_ogre"
		file.open("user://global.txt", File.WRITE)
		file.store_var(enemy)
		file.close() 
	inArea = true
	print(inArea)
