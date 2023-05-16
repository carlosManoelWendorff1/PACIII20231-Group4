extends Control

var enemy_life = null;
var player_life = null;
var input = null;

var inAttack = false;
var accuracy_sum = 0;
var number_of_attacks = 0;
var attack_selected = false;
var attack_difficult = 0;
onready var parent = self.get_parent();
var start_value = ''
var text = ""
export var time_for_attack = 120

func _get_prompt(number_of_words: int):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")
	var error = http_request.request("https://random-word-api.vercel.app/api?words=" + str(number_of_words))
	print(error)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	return "1"

func _http_request_completed(result, response_code, headers, body):
	var words = []
	
	print(response_code)

	if(response_code == 200):
		var json = parse_json(body.get_string_from_utf8())
		if json != null and json.size() > 0:
			for i in json:
				words.append(i)

		text = " ".join(words)
	else:
		print('response_code: ', response_code)
		print('problem on the server')

func start(value: int):
	start_value = value
	if(attack_selected):
		self._get_prompt(25)
		$Timer.count(value)
		$Arrow.text = ''
		$attack1.visible = false
		$attack2.visible = false
		$attack3.visible = false
		$attack4.visible = false
		attack_selected = false
	$attack1.grab_focus()
	
func start_attack(words: int = 5) -> void:
	if not inAttack:
		var number_of_words = 5;
		if words > 20:
			number_of_words = 20;
		elif words < 1: 
			number_of_words = 1;
		else:
			number_of_words = words;
		
		input.set_desired_text(text);
		inAttack = true;
		input.start();

func _ready():
	input = get_node("input_text");
	enemy_life = self.get_parent().get_node("EnemyLife")
	player_life = self.get_parent().get_node("PlayerLife")
	$attack1.grab_focus()
	$Arrow.text = '>'
	$attack1.visible = true
	$attack2.visible = true
	$attack3.visible = true
	$attack4.visible = true
	
func clear():
	inAttack = false;
	input.end();

func process_input_result(accuracy: float) -> void:
	inAttack = false;
	accuracy_sum += accuracy;
	number_of_attacks += 1;
	var target = null;
	var multiplier = 1;
	input.end();
	if(accuracy >= 70):
		target = enemy_life; 
		if(accuracy == 100):
			multiplier =2
		$Timer.message("HIT\nAccuracy: " + str(round_to_dec(accuracy, 2)) + "%");
		## TODO: Chamar a animação de ataque do player
	else:
		target = player_life; 
		if(accuracy == 0):
			multiplier =2
		$Timer.message("MISS\nAccuracy: " + str(round_to_dec(accuracy, 2)) + "%");
		## TODO: Chamar a animação de ataque do inimigo
	yield(get_tree().create_timer(1.0), "timeout")
	var damage = randi() % 15 + 15;
	target.take_damage(damage * multiplier)
	parent.openMenu();

func get_accuracy() -> float:
	return accuracy_sum/number_of_attacks;

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func end_battle():
	accuracy_sum = 0;
	number_of_attacks = 0;

func _on_attack2_focus_entered():
	$Arrow.rect_position = Vector2(24,56)
	attack_selected = true
	attack_difficult = 1

func _on_attack3_focus_entered():
	$Arrow.rect_position = Vector2(24,88)

func _on_attack4_focus_entered():
	$Arrow.rect_position = Vector2(24,120)
	pass # Replace with function body.

func _on_attack1_focus_entered():
	$Arrow.rect_position = Vector2(24,23)


func _on_attack1_pressed():
	start(120)
	time_for_attack = 120

func _on_attack2_pressed():
	start(90)
	time_for_attack = 90

func _on_attack3_pressed():
	start(75)
	time_for_attack = 75

func _on_attack4_pressed():
	start(60)
	time_for_attack = 60

