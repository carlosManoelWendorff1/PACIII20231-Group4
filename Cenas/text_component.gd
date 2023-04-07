extends Control

var enemy_life = null;
var player_life = null;
var input = null;

var inAttack = false;
var accuracy_sum = 0;
var number_of_attacks = 0;

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
	return res.substr(0, 1).to_upper() + res.substr(1).to_lower()

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
	# TODO: Remover quando existir um método que inicia o ataque;
	self.temp();

func process_input_result(accuracy: float) -> void:
	inAttack = false;
	accuracy_sum += accuracy;
	number_of_attacks += 1;
	if(accuracy >= 70):
		var damage = randi() % 15 + 15;
		if(accuracy == 100):
			damage *=2
			print("Critical Hit")
		else:
			print("Hit")
		print("Damage: " + str(damage))
		enemy_life.take_damage(damage)
	else:
		var damage = randi() % 15 + 15;
		if(accuracy == 0):
			damage *=2
			print("Critical Miss")
		else:
			print("Miss")
		print("Damage: " + str(damage))
		player_life.take_damage(damage)
	input.end();
	# TODO: Remover quando existir um método que inicia o ataque;
	self.temp();

func get_accuracy() -> float:
	return accuracy_sum/number_of_attacks;

func end_battle():
	accuracy_sum = 0;
	number_of_attacks = 0;

func temp():
	randomize();
	var word_index = randi() % 20;
	start_attack(word_index);
