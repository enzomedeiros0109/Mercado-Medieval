extends HBoxContainer

signal remove_pressed()

@onready var item_name_label = $ItemNameLabel
@onready var quantity_label  = $QuantityLabel
@onready var remove_button   = $RemoveButton

func _ready():
	remove_button.pressed.connect(func(): emit_signal("remove_pressed"))

func setup(item_name: String, quantity: int):
	item_name_label.text = item_name
	update_quantity(quantity)

func update_quantity(quantity: int):
	quantity_label.text = "x %d" % quantity
