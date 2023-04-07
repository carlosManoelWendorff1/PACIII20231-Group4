extends RichTextLabel

var gray = Color("#A9A9A9")
var white = Color("#FFFFFF")
var red = Color("#a65455")

var desired_text = "Vai tomar no cu davy jones"

var hasText = false
var oldText = ""
var letterIndex = -1
var whiteBar = format_color("|", white)
var rightAnswers = 0

func _ready():
	init_text()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var inputEvent = event as InputEventKey
		var typed_key = PoolByteArray([inputEvent.unicode]).get_string_from_utf8()
		if(!!hasText):
			var next_key = desired_text.substr(letterIndex, 1)
			if(typed_key == next_key):
				go_to_next_char(true);
				rightAnswers += 1
			else:
				go_to_next_char(false);
			if(letterIndex == desired_text.length()):
				print(rightAnswers)
				var accuracy = (float(rightAnswers)/desired_text.length())*100;
				print("Accuracy: " + String(round(accuracy)) + "%")
				hasText = false
				letterIndex = -1

func init_text():
	hasText = true;
	letterIndex = 0;
	rightAnswers = 0
	var restText = format_color(desired_text.substr(0, desired_text.length() - 1), gray)
	self.parse_bbcode("[center]" + whiteBar + restText + "[/center]");

func go_to_next_char(right: bool) -> void:
	oldText += format_color(desired_text.substr(letterIndex, 1), white if right else red)
	letterIndex += 1
	var remainingText = format_color(desired_text.substr(letterIndex, desired_text.length() - letterIndex + 1), gray);
	self.parse_bbcode("[center]" + oldText + whiteBar + remainingText + "[/center]");

func format_color(subText: String, color: Color):
	return "[color=#" + color.to_html(false) + "]" + subText + "[/color]";
