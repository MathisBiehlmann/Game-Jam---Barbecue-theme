extends CanvasLayer
@onready var main_menu = preload("res://scenes/main_menu.tscn")

var pause = false

func pause_unpause():
	pause = !pause
	
	
	if (pause):
		get_tree().paused = true
		show()
	else:
		get_tree().paused = false
		hide()


func _input(event):
	if event.is_action_pressed("pause"):
		pause_unpause()


func _on_resume_button_button_down() -> void:
	pause_unpause()


func _on_options_button_button_down() -> void:
	pass # Replace with function body.


func _on_restart_button_button_down() -> void:
	pause_unpause()
	get_tree().reload_current_scene()


func _on_main_menu_button_button_down() -> void:
	pause_unpause()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
