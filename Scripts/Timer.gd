extends RichTextLabel

var parent = null;

func _ready():
	parent = self.get_parent()
	
func count(value: int):
	self.visible = true;
	self.print("3");
	yield(get_tree().create_timer(1.0), "timeout")
	self.print("2");
	yield(get_tree().create_timer(1.0), "timeout")
	self.print("1");
	yield(get_tree().create_timer(1.0), "timeout")
	parent.get_parent().start_countdown();
	parent.start_attack(value);
	self.visible = false;

func message(message: String):
	self.visible = true;
	self.print(message)
	yield(get_tree().create_timer(1.0), "timeout")
	self.visible = false;

func print(value: String):
	self.bbcode_text = "[center]" + value + "[/center]"
