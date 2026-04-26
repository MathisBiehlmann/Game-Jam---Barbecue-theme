extends CanvasLayer

func _on_retry_button_button_down() -> void:
	get_tree().reload_current_scene()


func _on_main_menu_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
