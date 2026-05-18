extends CanvasLayer

@onready var pontos_label  = $HBoxContainer/PontosLabel
@onready var acertos_label = $HBoxContainer/AcertosLabel
@onready var erros_label   = $HBoxContainer/ErrosLabel

func _ready():
	GameManager.points_changed.connect(_on_points_changed)
	_update_labels()

func _on_points_changed(_new_points: int):
	_update_labels()

func _update_labels():
	pontos_label.text  = "⭐ %d pts" % GameManager.points
	acertos_label.text = "✅ %d"     % GameManager.total_correct
	erros_label.text   = "❌ %d"     % GameManager.total_wrong
