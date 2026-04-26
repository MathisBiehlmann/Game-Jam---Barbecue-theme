extends Area2D

@onready var music: AudioStreamPlayer = $Defeat
@onready var game_over_screen = $"../game_over_screen"

func _ready() -> void:
	game_over_screen.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		game_over_screen.show()
		
		body.set_physics_process(false)
		
		music.play()
		
