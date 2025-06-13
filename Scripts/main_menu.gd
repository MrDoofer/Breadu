extends CanvasLayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
			get_tree().quit()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_settings_pressed() -> void:
	null
