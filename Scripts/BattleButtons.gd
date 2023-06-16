extends Control

var text_component = null;
var shown_tutorial = false;
onready var parent = self.get_parent();

func _ready():
	text_component = self.get_parent().get_node("TextComponent")
	text_component.inAttack
	$AttackButton.grab_focus()
	
	
func _start_countdown():
	$Countdown.start(30.0);
	
func _on_Button_pressed():
	randomize();
	var word_index = randi() % 20;
	if not shown_tutorial:
		self.get_parent().get_node("BattleOptions").show_popup();
		shown_tutorial = true;
	parent.attack();
	text_component.start(word_index);

func _on_RunButton_pressed():
	parent.run();
