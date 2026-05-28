extends Panel

signal next_pressed()

@onready var result_label = $VBoxContainer/ResultsLabel    # "Acertou! 🎉" ou "Errou! 😔"
@onready var answer_label = $VBoxContainer/AnswerLabel    # explicação da resposta
@onready var next_button  = $VBoxContainer/NextButton

func _ready():
	next_button.pressed.connect(func(): emit_signal("next_pressed"))

func show_result(correct: bool, cart: Dictionary, correct_order: Dictionary):
	if correct:
		$Certo.play()
		result_label.text = "Parabéns! Você acertou!"
		answer_label.text = "Pedido entregue corretamente!"
	else:
		$Errado.play()
		result_label.text = "Pedido incorreto! Veja o que aconteceu:"
		var answer = ""
		
		# 1. Verificar itens que eram esperados (Quantidades erradas ou itens faltando)
		for item_name in correct_order:
			var correct_qty = correct_order[item_name]
			
			if item_name in cart:
				var given_qty = cart[item_name]
				if given_qty != correct_qty:
					answer += "• Erro na quantidade de %s: você colocou %d, mas o certo era %d.\n" % [item_name, given_qty, correct_qty]
			else:
				# O jogador esqueceu de colocar este item obrigatório
				answer += "• Item faltando: você esqueceu de colocar %s (o certo era %d).\n" % [item_name, correct_qty]
		
		# 2. Verificar se o jogador colocou itens que NÃO deveriam estar ali (Itens errados)
		for item_name in cart:
			if not item_name in correct_order:
				answer += "• Item incorreto: você colocou %s, mas o cliente não pediu isso!\n" % item_name
				
		answer_label.text = answer
	show()
