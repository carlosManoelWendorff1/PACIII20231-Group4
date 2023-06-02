extends Area2D

onready var animation_player = get_node("Slash1/AnimationPlayer1")
onready var animation_player2 = get_node("SlashArea2/Slash2/AnimationPlayer2")
onready var animation_player3 = get_node("SlashArea3/Slash3/AnimationPlayer3")

func _ready():
	set_process(true)
	animation_player.play("Slash")
	animation_player2.play("Slash")
	animation_player3.play("Slash")

func _process(delta):
	var speed_x = 0
	var speed_y = 0
	var motion = Vector2(speed_x, speed_y)
	set_position(get_position() + motion * delta)
	
	

func _on_VisibilityNotifier2D_screen_entered():
	yield(get_tree().create_timer(1), "timeout")
	queue_free()
