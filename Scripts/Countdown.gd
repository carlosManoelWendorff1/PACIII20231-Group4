extends Control

var timeLeft = 0;
var ended = true;

func _physics_process(delta):
	if not ended:
		if timeLeft >= 0:
			$Sec.set_text(str(timeLeft));
		else:
			end();

func _on_Timer_timeout():
	timeLeft -= 1;

func stop():
	print("stop");
	ended = true;
	$Timer.stop()
	timeLeft = 0;

func end():
	print("end");
	ended = true;
	$Timer.stop()
	self.get_parent().attack_timeout();

func start(seconds: float):
	timeLeft = seconds;
	ended = false;
	print("start");
	$Timer.start()
