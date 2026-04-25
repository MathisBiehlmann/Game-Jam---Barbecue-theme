extends Node2D

@export var sequence: Array[Key] = [KEY_H, KEY_U, KEY_G, KEY_O]

var input_buffer: Array[Key] = []
var current_track: int = 0

@onready var tracks: Array = [$Main_music, $Tour_du_monde]

# _ready() supprimé, l'autoplay s'occupe de lancer la musique

func _input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.pressed or event.echo:
		return

	input_buffer.append(event.keycode)

	if input_buffer.size() > sequence.size():
		input_buffer.pop_front()

	if input_buffer == sequence:
		_change_music()
		input_buffer.clear()

func _change_music() -> void:
	var old_track = tracks[current_track]
	current_track = (current_track + 1) % tracks.size()
	var new_track = tracks[current_track]

	var tween = create_tween()
	tween.tween_property(old_track, "volume_db", -40.0, 0.5)
	tween.tween_callback(func():
		old_track.stop()
		old_track.volume_db = 0.0
		new_track.play()
)
