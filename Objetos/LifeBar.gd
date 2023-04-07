extends ProgressBar

var life = 100

func _ready():
	percent_visible = true


func _physics_process(delta):
	value = life
	if life <= 0:
		die()

func take_damage(damage):
	life -= damage

func die():
	SceneTransition.change_scene("res://UI/Battle_result/BattleResultMenu.tscn")
