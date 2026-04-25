extends Control
@onready var level_1 = preload("res://scenes/level.tscn")

func _on_play_button_button_down() -> void:
	get_tree().change_scene_to_packed(level_1)

func _on_leave_button_button_down() -> void:
	get_tree().quit()
