extends CanvasLayer

func _input(event):
	if event.is_action_pressed("pause"):
		hide()

func _on_collector_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_time_button_button_down() -> void:
	pass # Replace with function body.


func _on_free_button_button_down() -> void:
	pass # Replace with function body.


func _on_back_button_button_down() -> void:
	hide()
