extends Node2D

export var IS_PLAYER = false;
export var NAME = "";
var BattleResultVictory = "res://Scenes/BattleResultVictory.tscn"
var BattleResultDefeat = "res://Scenes/BattleResultDefeat.tscn"

var life = 100

func _ready():
	$RichTextLabel.text = NAME;
	$ProgressBar.percent_visible = true;

func _physics_process(delta):
	$ProgressBar.value = life
	if life <= 0:
		die()

func take_damage(damage):
	life -= damage

func die():
	if (IS_PLAYER):
		SceneTransition.change_scene(BattleResultDefeat)
	else:
		SceneTransition.change_scene(BattleResultVictory)
