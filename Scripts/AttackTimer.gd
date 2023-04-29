extends Timer

var ms = 0;
var s = 0;

func _process(delta):
	if ms > 9:
		s+= 1;
		ms = 0;
	if s > 59:
		s = 0;
	set_text(str(s)+":"+str(ms));
