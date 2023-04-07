extends Control

signal finished

onready var timer: Timer = get_node("Timer")
onready var animation: AnimationPlayer = get_node("Animation")
onready var label_name: Label = get_node("Background/Name")
onready var text_label: RichTextLabel = get_node("Background/TextLabel")

var can_skip_dialogue: bool = false
var dialogue_size: int
var dialogue_index: int = 0

var dialogue_list: Dictionary = {
	"dialogue": [
		"Um monstro se aproxima.",
		"Que a batalha comece."
	],
	
	"name": "Narrador"
}

export(float) var wait_time = 0.02

func _ready() -> void:
	animation.play("fade_in")
	dialogue_size = dialogue_list["dialogue"].size()
	
	if dialogue_list["name"] != null:
		label_name.text = dialogue_list["name"]
		text_label.rect_position = Vector2(50,50)
		
	show_dialogue()
	
func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_accept") and can_skip_dialogue:
		can_skip_dialogue = false
		show_dialogue()

func show_dialogue() -> void:
	if dialogue_index == dialogue_size:
		animation.play("fade_out")
		yield(animation, "animation_finished")
		emit_signal("finished")
		queue_free()
		get_tree().change_scene("res://Cenas/CenaLuta.tscn")
		return
		
	text_label.percent_visible = 0
	text_label.text = dialogue_list["dialogue"][dialogue_index]
	
	dialogue_index += 1
	
	while text_label.visible_characters < len(text_label.text):
		text_label.visible_characters += 1
		timer.start(wait_time)
		yield(timer,"timeout") 
	
	can_skip_dialogue = true
