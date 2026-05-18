extends Panel

signal item_clicked(item: Dictionary)

# Caminhos corrigidos para bater com sua árvore
@onready var potions_grid = $HBoxContainer/PotionsColumn/PotionsGrid
@onready var ingredients_grid = $HBoxContainer/IngredientsColumn/IngredientsGrid
@onready var equipments_grid  = $HBoxContainer/EquipmentsColumn/EquipmentsGrid

var item_button_scene = preload("res://scenes/item_button.tscn")

var items_data = {
	"potions": [
		{ "name" : "Poção de Cura",  "icon": "res://sprites/Provisory_Potion.png"},
		{ "name": "Poção de Mana",  "icon": "res://sprites/Provisory_Potion.png"  },
		{ "name": "Antídoto",       "icon": "res://sprites/Provisory_Potion.png"  },
	],
	"ingredients": [
		{ "name": "Erva Lunar",     "icon": "res://sprites/Provisory_Potion.png" },
		{ "name": "Perna de Sapo",  "icon": "res://sprites/Provisory_Potion.png" },
		{ "name": "Olho de Aranha", "icon": "res://sprites/Provisory_Potion.png" },
	],
	"equipment": [
		{ "name": "Flecha",         "icon": "res://sprites/Provisory_Potion.png" },
		{ "name": "Espada Longa",   "icon": "res://sprites/Provisory_Potion.png" },
		{ "name": "Escudo",         "icon": "res://sprites/Provisory_Potion.png" },
	],
}


func _ready():
	_populate_grid(potions_grid, items_data["potions"])
	_populate_grid(ingredients_grid, items_data["ingredients"])
	_populate_grid(equipments_grid, items_data["equipment"])


func _populate_grid(grid: GridContainer, items: Array):
	for item in items:
		var btn = item_button_scene.instantiate()
		btn.pressed.connect(_on_item_button_pressed.bind(item))
		grid.add_child(btn)                      # ← entra na cena, @onready é preenchido
		btn.setup(item)


func _on_item_button_pressed(item: Dictionary):
	emit_signal("item_clicked", item)
