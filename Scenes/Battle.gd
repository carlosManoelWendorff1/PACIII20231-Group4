extends Node2D

var mode = "menu";

func attack():
	mode = "attack";
	$BattleButtons.visible = false;
	$TextComponent.visible = true;
	
func openMenu():
	mode = "menu";
	$BattleButtons.visible = true;
	$TextComponent.visible = false;

func run():
	randomize();
	var chance = randi() % 10 + 1; 
	if chance == 1:
		SceneTransition.change_scene("res://Scenes/FistStage.tscn")
	else:
		var damage = randi() % 15 + 15;
		$PlayerLife.take_damage(damage)
