extends Control
@onready var choose_menu = $choose_menu

func _ready() -> void:
	choose_menu.hide()

func _on_play_button_button_down() -> void:
	choose_menu.show()

func _on_leave_button_button_down() -> void:
	get_tree().quit()
