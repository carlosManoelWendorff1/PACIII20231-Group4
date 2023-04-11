extends RichTextLabel

var gray = Color("#A9A9A9")
var white = Color("#FFFFFF")
var red = Color("#a65455")

var oldText = ""
var letterIndex = -1
var whiteBar = _format_color("|", white)
var rightAnswers = 0
var desired_text = null;
var running: bool = false;
var manager = null;

func start() -> void:
	if !!desired_text:
		running = true;

func end() -> void:
	running = false;
	oldText = "";
	letterIndex = -1;
	rightAnswers = 0;
	desired_text = null;
	self.parse_bbcode("");

func set_desired_text(text: String) -> void:
	desired_text = text
	_init_text();

func _ready():
	manager = self.get_parent();

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo() and running and letterIndex < desired_text.length():
		var inputEvent = event as InputEventKey
		var typed_key = PackedByteArray([inputEvent.unicode]).get_string_from_utf8()
		if _check_if_side_key(inputEvent, typed_key):
			return;
		var next_key = desired_text.substr(letterIndex, 1)
		if(typed_key.to_lower() == next_key):
			_go_to_next_char(true);
			rightAnswers += 1
		else:
			_go_to_next_char(false);
		if(letterIndex == desired_text.length()):
			var accuracy = (float(rightAnswers)/desired_text.length())*100;
			manager.process_input_result(accuracy);

func _check_if_side_key(event: InputEventKey, typed_key: String) -> bool:
	return typed_key == "" and event.keycode != KEY_SPACE;

func _init_text():
	letterIndex = 0;
	rightAnswers = 0
	var restText = _format_color(desired_text.substr(0, desired_text.length()), gray)
	self.parse_bbcode("[center]" + whiteBar + restText + "[/center]");

func _go_to_next_char(right: bool) -> void:
	oldText += _format_color(desired_text.substr(letterIndex, 1), white if right else red)
	letterIndex += 1
	var remainingText = "";
	if(letterIndex < desired_text.length()):
		remainingText = _format_color(desired_text.substr(letterIndex, desired_text.length() - letterIndex + 1), gray);
	self.parse_bbcode("[center]" + oldText + whiteBar + remainingText + "[/center]");

func _format_color(subText: String, color: Color):
	return "[color=#" + color.to_html(false) + "]" + subText + "[/color]";
