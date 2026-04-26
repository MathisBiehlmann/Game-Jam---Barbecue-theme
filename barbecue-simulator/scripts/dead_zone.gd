extends Area2D

@onready var music: AudioStreamPlayer = $Defeat

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		# Bloque le personnage
		body.set_physics_process(false)
		
		music.play()
		await music.finished
		
		body.set_physics_process(true)
		get_tree().reload_current_scene()
