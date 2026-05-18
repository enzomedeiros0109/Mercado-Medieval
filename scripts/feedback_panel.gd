extends Panel

signal next_pressed()

@onready var result_label = $VBoxContainer/ResultsLabel    # "Acertou! 🎉" ou "Errou! 😔"
@onready var answer_label = $VBoxContainer/AnswerLabel    # explicação da resposta
@onready var next_button  = $VBoxContainer/NextButton

func _ready():
	next_button.pressed.connect(func(): emit_signal("next_pressed"))

func show_result(correct: bool, given: int, expected: int):
	if correct:
		result_label.text = "🎉 Parabéns! Você acertou!"
		answer_label.text  = "A resposta é %d. Muito bem!" % expected
	else:
		result_label.text = "😔 Quase! Você colocou %d." % given
		answer_label.text  = "A resposta certa era %d.\nTente no próximo!" % expected
	show()
