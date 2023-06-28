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
	var file = File.new()
	file.open("user://tutorial.txt", File.READ)
	var file_contents = file.get_as_text();
	print("second")
	print(file_contents)
	file.close()
	if file_contents != "true":
		self.get_parent().get_node("BattleOptions").show_popup();
		file.open("user://tutorial.txt", File.WRITE)
		file.store_string("true")
		file.close()
	parent.attack();
	text_component.start(word_index);

func _on_RunButton_pressed():
	parent.run();
