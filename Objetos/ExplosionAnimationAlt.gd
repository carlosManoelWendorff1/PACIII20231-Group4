extends Area2D

onready var animation_player = get_node("Sprite/AnimationPlayer2")

func _ready():
	set_process(true)
	animation_player.play("Explosion")
	
func _process(delta):
	var speed_x = 0
	var speed_y = 0
	var motion = Vector2(speed_x, speed_y)
	set_position(get_position() + motion * delta)


func _on_VisibilityNotifier2D_screen_entered():
	yield(get_tree().create_timer(3.6), "timeout")
	queue_free()
