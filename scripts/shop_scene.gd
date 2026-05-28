# ShopScene.gd
extends Node

@onready var customer_panel  = $CostumerPanel
@onready var cart_panel      = $CartPanel
@onready var cart_panel_items = $CartPanel/CartItemList
@onready var shop_panel      = $ShopPanel
@onready var shop_panel_items = $ShopPanel/HBoxContainer
@onready var deliver_button = $CartPanel/DeliverButton
@onready var feedback_panel  = $FeedbackPanel

var current_customer: Dictionary = {}

var customer_pool: Array = [
	{
		"name": "Mago Valerius",
		"sprite": "res://sprites/spritesclientes/MagoValerius.png",
		"problem": "Olá! Quero comprar poções de mana.\nVou usar 2 feitiços hoje e cada\num gasta 3 poções. Me vê o total!",
		"correct_order": {
			"Poção de Mana": 6
		}
	},
	{
		"name": "Caçador Nick",
		"sprite": "res://sprites/spritesclientes/CaçadorNick.png",
		"problem": "Meus 4 cães de caça foram envenenados!\nMe vende 2 antídotos para\ncada um deles, por favor.",
		"correct_order": {
			"Antídoto": 8
		}
	},
	{
		"name": "Curandeira Ana",
		"sprite": "res://sprites/spritesclientes/CurandeiraAna.png",
		"problem": "Bom dia! Vou levar ervas lunares.\nQuero fazer 5 chás medicinais e\nuso 2 ervas em cada panela.",
		"correct_order": {
			"Erva Lunar": 10
		}
	},
	{
		"name": "Bruxo Boris",
		"sprite": "res://sprites/spritesclientes/BruxoBoris.png",
		"problem": "Gostaria de pernas de sapo.\nTenho 20 moedas e cada uma custa 5.\nMe dá tudo o que meu dinheiro compra!",
		"correct_order": {
			"Perna de Sapo": 4
		}
	},
	{
		"name": "Alquimista Chloe",
		"sprite": "res://sprites/spritesclientes/AlquimistaChloe.png",
		"problem": "Vou levar olhos de aranha. Ponha na\nsacola o suficiente para 3 poções,\nsabendo que cada poção usa 4 olhos.",
		"correct_order": {
			"Olho de Aranha": 12
		}
	},
	{
		"name": "Arqueira Tyra",
		"sprite": "res://sprites/spritesclientes/ArqueiraTyra.png",
		"problem": "Preciso de flechas para a caçada.\nQuero encher minhas 2 aljavas,\ne cabem 10 flechas em cada uma.",
		"correct_order": {
			"Flecha": 20
		}
	},
	{
		"name": "Ferreiro Thorin",
		"sprite": "res://sprites/spritesclientes/FerreiroThorin.png",
		"problem": "Olá, patrão! Tenho 15 moedas de ouro.\nCada espada longa custa 5 moedas.\nMe venda o máximo que eu puder pagar.",
		"correct_order": {
			"Espada Longa": 3
		}
	},
	{
		"name": "Guarda Real Ben",
		"sprite": "res://sprites/spritesclientes/GuardaRealBen.png",
		"problem": "Somos um grupo de 6 cavaleiros na porta.\nCada um de nós precisa de 1 escudo.\nPode preparar o pedido para a gente!",
		"correct_order": {
			"Escudo": 6
		}
	},
	{
		"name": "Cavaleiro Arthur",
		"sprite": "res://sprites/spritesclientes/CavaleiroArthur.png",
		"problem": "Me dá poções de cura! Vou me aventurar\nna floresta por 3 dias e quero\ntomar 2 poções por dia para garantir.",
		"correct_order": {
			"Poção de Cura": 6
		}
	},
	{
		"name": "Elfa Elen",
		"sprite": "res://sprites/spritesclientes/ElfaElen.png",
		"problem": "Me vende algumas ervas lunares.\nPreciso de 4 delas para um feitiço\ne mais 5 para dar de presente.",
		"correct_order": {
			"Erva Lunar": 9
		}
	},
	{
		"name": "Goblin Grog",
		"sprite": "res://sprites/spritesclientes/GoblinGrog.png",
		"problem": "Vou fazer um sopão! Me vê algumas pernas \nde sapo e olhos de aranha:\nquero colocar 3 pernas e 1 olho em cada um\ndos meus 5 pratos de sopa.",
		"correct_order": {
			"Perna de Sapo": 15,
			"Olho de Aranha": 5
		}
	},
	{
		"name": "Feiticeira Luna",
		"sprite": "res://sprites/spritesclientes/FeiticeiraLuna.png",
		"problem": "Moço, tenho 16 moedas de prata.\nMe dá tudo em olhos de aranha!\nSabendo que cada um custa 2 moedas.",
		"correct_order": {
			"Olho de Aranha": 8
		}
	},
	{
		"name": "Rei Richard",
		"sprite": "res://sprites/spritesclientes/ReiRichard.png",
		"problem": "Quero comprar espadas longas para\nmeus dois filhos gêmeos da guarda.\nMe vê 1 para cada um deles.",
		"correct_order": {
			"Espada Longa": 2
		}
	},
	{
		"name": "Paladina Clara",
		"sprite": "res://sprites/spritesclientes/PaladinaClara.png",
		"problem": "Vou levar escudos para o batalhão.\nTenho 30 moedas de ouro e cada\nescudo pesado custa 10 moedas.",
		"correct_order": {
			"Escudo": 3
		}
	},
	{
		"name": "Viajante Toby",
		"sprite": "res://sprites/spritesclientes/ViajanteToby.png",
		"problem": "Me vê poções de cura! Meu dragão de\nestimação tomou 2 ontem e quer\nmais 5 hoje porque ainda está dodói.",
		"correct_order": {
			"Poção de Cura": 7
		}
	},
	{
		"name": "Ilusionista Zoro",
		"sprite": "res://sprites/spritesclientes/IlusionistaZoro.png",
		"problem": "Preciso de poções de mana para a guilda.\nSomos 2 magos e cada um de nós\nquer levar 5 poções na mochila.",
		"correct_order": {
			"Poção de Mana": 10
		}
	},
	{
		"name": "Bardo Jasp",
		"sprite": "res://sprites/spritesclientes/BardoJasp.png",
		"problem": "Vou levar ervas lunares! Tenho aqui\n18 moedas de bronze e cada maço\nda erva custa 6 moedas.",
		"correct_order": {
			"Erva Lunar": 3
		}
	}
]

func _ready():
	shop_panel.item_clicked.connect(_on_item_clicked)
	#cart_panel.deliver_pressed.connect(_on_deliver_pressed)
	if not cart_panel.deliver_pressed.is_connected(_on_deliver_pressed):
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
	#print(correct_order)

	shop_panel_items.hide()
	cart_panel_items.hide()
	deliver_button.hide()
	
	if _check_order(cart, correct_order):
		GameManager.add_correct()
		feedback_panel.show_result(true, cart, correct_order)
	else:
		GameManager.add_wrong()
		feedback_panel.show_result(false, cart, correct_order)


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
	shop_panel_items.show()
	cart_panel_items.show()
	deliver_button.show()
	_spawn_next_customer()
 
