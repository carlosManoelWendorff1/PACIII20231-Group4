extends Node2D

var mode = "menu";

func start_countdown():
	$Countdown.visible = true;
	$Countdown.start(30.0)

func attack():
	mode = "attack";
	$BattleButtons.visible = false;
	$TextComponent.visible = true;
	
func openMenu():
	mode = "menu";
	$Countdown.visible = false;
	$Countdown.stop();
	$BattleButtons.visible = true;
	$TextComponent.visible = false;

func end():
	mode = "end";
	$Countdown.visible = false;
	$BattleButtons.visible = false;
	$TextComponent.visible = false;

func run():
	$BattleButtons.visible = false;
	$TextComponent.visible = true;
	randomize();
	var chance = randi() % 10 + 1; 
	if chance == 1:
		$TextComponent/Timer.message("Successful scape!");
		yield(get_tree().create_timer(1.0), "timeout")
		SceneTransition.change_scene("res://Scenes/FistStage.tscn")
	else:
		var damage = randi() % 15 + 15;
		$TextComponent/Timer.message("Failed to run!");
		## TODO: Chamar a animação de ataque do inimigo
		yield(get_tree().create_timer(1.0), "timeout")
		$PlayerLife.take_damage(damage)
	$BattleButtons.visible = true;
	$TextComponent.visible = false;

func attack_timeout():
	var damage = randi() % 15 + 15;
	$Countdown.visible = false;
	$TextComponent.clear();
	$TextComponent/Timer.message("Attack timeout!");
	## TODO: Chamar a animação de ataque do inimigo
	yield(get_tree().create_timer(1.0), "timeout")
	$PlayerLife.take_damage(damage)
	$BattleButtons.visible = true;
	$TextComponent.visible = false;
