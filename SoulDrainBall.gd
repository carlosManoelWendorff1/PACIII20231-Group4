extends Area2D

const souldrainball_speed = 200
onready var animation_player = get_node("Sprite/AnimationPlayer2")

func _ready():
	set_process(true)
	animation_player.play("soulball")
	
func _process(delta):
	var speed_x = -1
	var speed_y = 0.2
	var motion = Vector2(speed_x, speed_y) * souldrainball_speed
	set_position(get_position() + motion * delta)


func _on_VisibilityNotifier2D_screen_entered():
	yield(get_tree().create_timer(1.1), "timeout")
	queue_free()
	
