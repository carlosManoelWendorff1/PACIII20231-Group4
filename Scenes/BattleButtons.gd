extends Control

var text_component = null;
onready var parent = self.get_parent();

func _ready():
	text_component = self.get_parent().get_node("TextComponent")
	
func _on_Button_pressed():
	randomize();
	var word_index = randi() % 20;
	parent.attack();
	text_component.start(word_index);

func _on_RunButton_pressed():
	parent.run();
