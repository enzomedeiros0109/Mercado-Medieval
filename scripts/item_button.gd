extends Button

@onready var icon_rect = $VBoxContainer/IconRect
@onready var name_label = $VBoxContainer/NameLabel


func setup(item: Dictionary):
	print("icon_rect: ", icon_rect)
	print("name_label: ", name_label)
	name_label.text = item["name"]
	var tex = load(item["icon"])
	if tex:
		icon_rect.texture = tex
