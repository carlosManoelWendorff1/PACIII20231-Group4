extends Control

var enemy_life = null;
var player_life = null;
var input = null;

var inAttack = false;
var accuracy_sum = 0;
var number_of_attacks = 0;
onready var parent = self.get_parent();

var words = ["abacaxi", "amigo", "animal", "arroz", "aventura", "bala", "bolo", "cachorro", "caminho", "carro", "casaco", "cidade", "comida", "corpo", "dia", "dinheiro", "escola", "esporte", "festa", "filme", "frio", "futebol", "gato", "hotel", "jogo", "livro", "loja", "mala", "mar", "musica", "noite", "novo", "oeste", "pao", "papel", "peixe", "pessoa", "praia", "quarto", "roupa", "sapato", "telefone", "tempo", "terra", "trabalho", "universidade", "verao", "viagem", "vida", "voo"];

func _get_prompt(number_of_words: int) -> String:
	var res = "";
	var is_in_first_word = true;
	randomize();
	for n in number_of_words:
		var word_index = randi() % words.size()
		var word = words[word_index]
		if is_in_first_word:
			res = word; 
			is_in_first_word = false;
		else:
			res += " "  + word; 
	return res.to_lower()


func start(value: int):
	$Timer.count(value);

func start_attack(words: int = 5) -> void:
	if not inAttack:
		var number_of_words = 5;
		if words > 20:
			number_of_words = 20;
		elif words < 1: 
			number_of_words = 1;
		else:
			number_of_words = words;
		input.set_desired_text(self._get_prompt(number_of_words));
		inAttack = true;
		input.start();

func _ready():
	input = get_node("input_text");
	enemy_life = self.get_parent().get_node("EnemyLife")
	player_life = self.get_parent().get_node("PlayerLife")

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
