extends Node2D

export var IS_PLAYER = false;
export var NAME = "";
export var DEATH_SCENE = "res://Scenes/BattleResultMenu.tscn";

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
	self.get_parent().end();
	SceneTransition.change_scene(DEATH_SCENE)
