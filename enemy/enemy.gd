extends KinematicBody2D

onready var animation: AnimationPlayer = get_node("Sprite/AnimationPlayer")

const SPEED = 10000
var motion = Vector2.ZERO
var inArea = false
export var camera_speed = 1
var enemy = ""

func _physics_process(delta):
	animate()

func animate() -> void:
	if motion == Vector2.ZERO:
		animation.play("iddle")

func _ready():
	var file = File.new()
	if file.file_exists("user://global.txt"):
		file.open("user://global.txt", File.READ)
		enemy = file.get_var()
		print(enemy)
		if(enemy == 'skelleton'):
			$Sprite2.visible = true
			$Sprite2/AnimationPlayer.play("idle")
		if(enemy == 'ogre'):
			$Sprite.visible = true
			$Sprite/AnimationPlayer.play("idle")
		if(enemy == 'mini_ogre'):
			$Sprite3.visible = true
			$Sprite3/AnimationPlayer.play("iddlesecond")
		file.close()
