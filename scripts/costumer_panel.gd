extends Panel

@onready var sprite = $SpriteCliente
@onready var name_label = $NameLabel
@onready var problem_label = $BalaoDeFala/ProblemLabel

func load_customer(customer: Dictionary):
	name_label.text = customer["name"]
	problem_label.text = customer["problem"]

	var tex = load(customer["sprite"])
	if tex:
		sprite.texture = tex
