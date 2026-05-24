# ShopScene.gd
extends Node

@onready var customer_panel  = $CostumerPanel
@onready var cart_panel      = $CartPanel
@onready var shop_panel      = $ShopPanel
@onready var feedback_panel  = $FeedbackPanel

var current_customer: Dictionary = {}

var customer_pool: Array = [
	{
		"name": "Mago Aldric",
		"sprite": "res://sprites/pfpless.png",
		"problem": "Preciso tomar poções de cura\nduas vezes ao dia durante 8 dias.\nQuantas poções devo levar?",
		"correct_order": {
			"Poção de Cura": 16
		}
	},
	{
		"name": "Guerreira Lira",
		"sprite": "res://sprites/pfpless.png",
		"problem": "Tenho 20 moedas e cada flecha\ncusta 4 moedas. Quantas flechas\nconsigo comprar?",
		"correct_order": {
			"Flecha": 5
		}
	},
	{
		"name": "Druida Fennor",
		"sprite": "res://sprites/pfpless.png",
		"problem": "Preciso de ingredientes para\n3 poções. Cada poção usa\n4 ervas. Quantas ervas no total?",
		"correct_order": {
			"Erva Lunar": 12
		}
	},
]

func _ready():
	shop_panel.item_clicked.connect(_on_item_clicked)
	cart_panel.deliver_pressed.connect(_on_deliver_pressed)
	feedback_panel.next_pressed.connect(_on_next_customer)
	feedback_panel.hide()
	_spawn_next_customer()

func _spawn_next_customer():
	current_customer = customer_pool[randi() % customer_pool.size()]
	customer_panel.load_customer(current_customer)
	cart_panel.clear_cart()

func _on_item_clicked(item: Dictionary):
	cart_panel.add_item(item)

func _on_deliver_pressed():
	var cart = cart_panel.get_cart()
	var correct_order = current_customer["correct_order"]

	shop_panel.hide()
	cart_panel.hide()

	if _check_order(cart, correct_order):
		GameManager.add_correct()
		var expected = correct_order.values()[0]
		var given = cart.values()[0] if cart.size() > 0 else 0
		feedback_panel.show_result(true, given, expected)
	else:
		GameManager.add_wrong()
		var expected = correct_order.values()[0]
		var given = cart.values()[0] if cart.size() > 0 else 0
		feedback_panel.show_result(false, given, expected)

func _check_order(cart: Dictionary, correct_order: Dictionary) -> bool:
	if cart.size() != correct_order.size():
		return false
	for item_name in correct_order:
		if not item_name in cart:
			return false
		if cart[item_name] != correct_order[item_name]:
			return false
	return true

func _on_next_customer():
	feedback_panel.hide()
	shop_panel.show()
	cart_panel.show()
	_spawn_next_customer()
 
