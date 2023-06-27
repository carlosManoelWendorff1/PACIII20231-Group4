extends Control

var ended = true;

func _on_Timer_timeout():
	end()
	
func stop():
	print("stop");
	ended = true;
	$Timer.stop()

func end():
	print("end");
	ended = true;
	$Timer.stop()
	self.get_parent().attack_timeout();

func start(seconds: float):
	ended = false;
	print("start")
	$Timer.start(seconds)
	$TimerBar.max_value = seconds
