extends Node2D

var mode = "menu";

func _ready():
	var file = File.new()
	file.open("user://tutorial.txt", File.READ)
	var file_contents = file.get_as_text();
	file.close()
	print(file_contents)
	if file_contents != "true":
		get_node("BattleButtonsPopup").show_popup();

func start_countdown():
	$Countdown.visible = true;
	var time = get_node("TextComponent").time_for_attack
	$Countdown.start(time)

func attack():
	mode = "attack";
	$BattleButtons.visible = false;
	$TextComponent.visible = true;
	$TextComponent/attack1.grab_focus()
	$TextComponent/Arrow.text = '>'
	$TextComponent/attack1.visible = true
	$TextComponent/attack2.visible = true
	$TextComponent/attack3.visible = true
	$TextComponent/attack4.visible = true
	
func openMenu():
	mode = "menu";
	$Countdown.visible = false;
	$Countdown.stop();
	$BattleButtons.visible = true;
	$TextComponent.visible = false;
	$BattleButtons/AttackButton.grab_focus()

func _physics_process(delta):
	$Player/Sprite/Animation.play("iddle")
	$Player/Sprite/Animation.play_backwards("iddle")
	$Player/Sprite/Animation.set_speed_scale(0.5)

func end():
	mode = "end";
	$Countdown.visible = false;
	$BattleButtons.visible = false;
	$TextComponent.visible = false;
	$BattleButtons/AttackButton.grab_focus()

func run():
	$BattleButtons.visible = false;
	$TextComponent.visible = true;
	randomize();
#	var chance = randi() % 10 + 1; 
	var chance = 2
	if chance == 1:
		$TextComponent/Timer.message("Successful escape!");
		$TextComponent/Arrow.text = ''
		$TextComponent/attack1.visible = false
		$TextComponent/attack2.visible = false
		$TextComponent/attack3.visible = false
		$TextComponent/attack4.visible = false
		yield(get_tree().create_timer(1.0), "timeout")
		SceneTransition.change_scene("res://Scenes/FistStage.tscn")
	else:
		var damage = randi() % 15 + 15;
		$TextComponent/Timer.message("Failed to run!");
		$TextComponent/Arrow.text = ''
		$TextComponent/attack1.visible = false
		$TextComponent/attack2.visible = false
		$TextComponent/attack3.visible = false
		$TextComponent/attack4.visible = false
		## TODO: Chamar a animação de ataque do inimigo
		yield(get_tree().create_timer(1.0), "timeout")
		$PlayerLife.take_damage(damage)
		_on_AttackButton_focus_entered()
		$BattleButtons/AttackButton.grab_focus()
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
	_on_AttackButton_focus_entered()
	$BattleButtons/AttackButton.grab_focus()


func _on_AttackButton_focus_entered():
	$BattleButtons/Attack.region_rect = Rect2(61.985,20.891,37.358,17.736)
	pass # Replace with function body.


func _on_RunButton_focus_entered():
	$BattleButtons/Run.region_rect = Rect2(66.219,-1.86,28.294,21.636)
	pass # Replace with function body.


func _on_AttackButton_focus_exited():
	$BattleButtons/Attack.region_rect = Rect2(0.007,19.382,31.857,18.868)
	pass # Replace with function body.


func _on_RunButton_focus_exited():
	$BattleButtons/Run.region_rect = Rect2(2,1,27,19)
	pass # Replace with function body.
