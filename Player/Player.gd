extends KinematicBody2D

const SPEED = 10000
var motion = Vector2.ZERO

func _physics_process(delta):
	motion = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		motion += Vector2(1, 0)
		set_rotation_degrees(0)
	if Input.is_action_pressed("ui_down"):
		motion += Vector2(0, 1)
		set_rotation_degrees(90)
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1, 0)
		set_rotation_degrees(180)
	if Input.is_action_pressed("ui_up"):
		motion += Vector2(0, -1)
		set_rotation_degrees(270)
	motion = motion.normalized() * SPEED * delta
	print(motion)
	move_and_slide(motion)
