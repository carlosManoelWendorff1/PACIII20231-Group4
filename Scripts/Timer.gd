extends RichTextLabel

var parent = null;

func _ready():
	parent = self.get_parent()
	
func count(value: int):
	self.visible = true;
	self.print(3);
	yield(get_tree().create_timer(1.0), "timeout")
	self.print(2);
	yield(get_tree().create_timer(1.0), "timeout")
	self.print(1);
	yield(get_tree().create_timer(1.0), "timeout")
	parent.start_attack(value);
	self.visible = false;

func print(value: int):
	self.bbcode_text = "[center]" + str(value) + "[/center]"
