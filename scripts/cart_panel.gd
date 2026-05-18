extends Panel

signal deliver_pressed()

@onready var cart_item_list = $CartItemList
@onready var deliver_button = $DeliverButton

var cart_item_scene = preload("res://scenes/cart_item.tscn")

# Dicionário: { "Poção de Cura": 3, "Erva Lunar": 2 }
var cart: Dictionary = {}

# Referência aos nós de cada item: { "Poção de Cura": <CartItem node> }
var cart_nodes: Dictionary = {}


func _ready():
	deliver_button.pressed.connect(func(): emit_signal("deliver_pressed"))
	

#-------------------------------------------------------------------------

func add_item(item: Dictionary):
	var item_name = item["name"]
	if item_name in cart:
		cart[item_name] += 1
		cart_nodes[item_name].update_quantity(cart[item_name])
	else:
		cart[item_name] = 1
		var node = cart_item_scene.instantiate()
		node.remove_pressed.connect(_on_remove_pressed.bind(item_name))
		cart_item_list.add_child(node)
		node.setup(item_name, 1)
		cart_nodes[item_name] = node

#-------------------------------------------------------------------------

func _on_remove_pressed(item_name: String):
	cart[item_name] -= 1

	if cart[item_name] <= 0:
		# Remove o item do carrinho completamente
		cart_nodes[item_name].queue_free()
		cart.erase(item_name)
		cart_nodes.erase(item_name)
	else:
		cart_nodes[item_name].update_quantity(cart[item_name])

#-------------------------------------------------------------------------

func clear_cart():
	cart.clear()
	cart_nodes.clear()
	for child in cart_item_list.get_children():
		child.queue_free()
		
#-------------------------------------------------------------------------

func get_cart() -> Dictionary:
	return cart.duplicate()
