extends Button

const EXTRA_SCENE = preload("res://scenes/extra.tscn")

func _on_pressed() -> void:
	var extra_scene_instance = EXTRA_SCENE.instantiate()
	get_tree().current_scene.add_child(extra_scene_instance)
