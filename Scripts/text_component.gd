extends Control

const fireball_scene = preload("res://Objetos/FireballAnimationAlt.tscn")
const explosion_scene = preload("res://Objetos/ExplosionAnimationAlt.tscn")
const slash_scene = preload("res://Objetos/SlashAnimationAlt.tscn")
const frostball_scene = preload("res://Objetos/FrostballAnimationAlt.tscn")
const souldrainball_scene = preload("res://Objetos/SoulDrainBallAnimationAlt.tscn")
const souldrain_scene = preload("res://Objetos/SoulDrainAnimationAlt.tscn")

var attack_name = ""
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

var base_damage = 15
var max_damage = 15
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
	if(accuracy >= 0):
		target = enemy_life; 
		if(accuracy == 100):
			multiplier =2
		$Timer.message("HIT\nAccuracy: " + str(round_to_dec(accuracy, 2)) + "%");
		match attack_name:
			"Fireball":
				var fireball = fireball_scene.instance()
				get_parent().add_child(fireball)
				yield(get_tree().create_timer(1.1), "timeout")
				var explosion = explosion_scene.instance()
				get_parent().add_child(explosion)
			"Frostball":
				var iceball = frostball_scene.instance()
				get_parent().add_child(iceball)
				yield(get_tree().create_timer(1.1), "timeout")
				var explosion = explosion_scene.instance()
				get_parent().add_child(explosion)
			"SoulDrain":
				var souldrain = souldrain_scene.instance()
				get_parent().add_child(souldrain)
				yield(get_tree().create_timer(0.864), "timeout")
				var souldrainball = souldrainball_scene.instance()
				get_parent().add_child(souldrainball)
			"FireballStorm":
				var fireball = fireball_scene.instance()
				get_parent().add_child(fireball)
				yield(get_tree().create_timer(1.1), "timeout")
				var explosion = explosion_scene.instance()
				get_parent().add_child(explosion)
				explosion.scale /= 1.5
				yield(get_tree().create_timer(0.2), "timeout")
				var fireball2 = fireball_scene.instance()
				get_parent().add_child(fireball2)
				fireball2.position =  Vector2(371,290)
				yield(get_tree().create_timer(1.1), "timeout")
				var explosion2 = explosion_scene.instance()
				get_parent().add_child(explosion2)
				explosion2.scale /= 1.5
				explosion2.position = Vector2(685,210)
				yield(get_tree().create_timer(0.2), "timeout")
				var fireball3 = fireball_scene.instance()
				get_parent().add_child(fireball3)
				fireball3.position = Vector2(371,366)
				yield(get_tree().create_timer(1.1), "timeout")
				var explosion3 = explosion_scene.instance()
				get_parent().add_child(explosion3)
				explosion3.scale /= 1.5
				explosion3.position = Vector2(685,286)
				
	else:
		target = player_life; 
		if(accuracy == 0):
			multiplier =2
		$Timer.message("MISS\nAccuracy: " + str(round_to_dec(accuracy, 2)) + "%");
		var slash = slash_scene.instance()
		get_parent().add_child(slash)
	yield(get_tree().create_timer(1.0), "timeout")
	var damage = randi() % max_damage + base_damage;
	target.take_damage(damage * multiplier)
	parent.openMenu();

func get_accuracy() -> float:
	return accuracy_sum/number_of_attacks;

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func end_battle():
	accuracy_sum = 0;
	number_of_attacks = 0;
	
func set_damage(damage_min: int, damage_max: int):
	max_damage = damage_max - damage_min;
	base_damage = damage_min;
	
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
	set_damage(5, 15)
	time_for_attack = 120
	attack_name = "Fireball"

func _on_attack2_pressed():
	start(90)
	set_damage(15, 25)
	time_for_attack = 90
	attack_name = "Frostball"

func _on_attack3_pressed():
	start(75)
	set_damage(25, 40)
	time_for_attack = 75
	attack_name = "SoulDrain"

func _on_attack4_pressed():
	start(60)
	set_damage(40, 60)
	time_for_attack = 60
	attack_name = "FireballStorm"
