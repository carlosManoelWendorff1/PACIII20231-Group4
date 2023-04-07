extends KinematicBody2D

onready var animation: AnimationPlayer = get_node("enemy/Animation")

const SPEED = 10000
var motion = Vector2.ZERO
var inArea = false
export var camera_speed = 1

func _physics_process(delta):
	animate()

func animate() -> void:
	if motion == Vector2.ZERO:
		animation.play("iddle")
