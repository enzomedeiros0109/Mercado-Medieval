extends Panel

signal next_pressed()

@onready var result_label = $VBoxContainer/ResultsLabel    # "Acertou! 🎉" ou "Errou! 😔"
@onready var answer_label = $VBoxContainer/AnswerLabel    # explicação da resposta
@onready var next_button  = $VBoxContainer/NextButton

func _ready():
	next_button.pressed.connect(func(): emit_signal("next_pressed"))

func show_result(correct: bool, cart: Dictionary, correct_order: Dictionary):
	if correct:
		result_label.text = "🎉 Parabéns! Você acertou!"
		answer_label.text = "Pedido entregue corretamente!"
	else:
		result_label.text = "😔 Quase! Verifique as quantidades."
		var answer = ""
		for item_name in correct_order:
			var correct_qty = correct_order[item_name]
			var given_qty   = cart[item_name] if item_name in cart else 0
			answer += "• %s: você colocou %d, o certo era %d\n" % [item_name, given_qty, correct_qty]
		answer_label.text = answer
	show()
