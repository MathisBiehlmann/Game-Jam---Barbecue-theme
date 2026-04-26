extends CharacterBody2D

# === MOUVEMENT ===
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# === GRAPIN ===
@onready var ray: RayCast2D = $RayCast2D
@onready var rope: Line2D = $Line2D
@onready var grapple_origin: Marker2D = $Marker2D
@onready var grapple_sound: AudioStreamPlayer = $GrappleSound
@onready var jump_sound: AudioStreamPlayer = $JumpSound

var grapple_point: Vector2 = Vector2.ZERO
var is_grappling: bool = false
const GRAPPLE_SPEED: float = 800.0
const GRAPPLE_RANGE: float = 400.0


func _physics_process(delta: float) -> void:
	if not is_on_floor() and not is_grappling:
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		if is_grappling:
			var to_grapple = (grapple_point - global_position).normalized()
			if Vector2(direction, 0).dot(Vector2(to_grapple.x, 0)) >= 0:
				velocity.x = direction * SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	_handle_grapple(delta)
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("grapple"):
		if is_grappling:
			_release_grapple()
		else:
			_shoot_grapple()


func _shoot_grapple() -> void:
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()

	ray.target_position = direction * GRAPPLE_RANGE
	ray.force_raycast_update()

	if ray.is_colliding():
		grapple_point = ray.get_collision_point()
		is_grappling = true
		rope.visible = true
		grapple_sound.play()


func _release_grapple() -> void:
	is_grappling = false
	rope.visible = false


func _handle_grapple(delta: float) -> void:
	if not is_grappling:
		rope.clear_points()
		return

	var direction = (grapple_point - global_position).normalized()
	velocity += direction * GRAPPLE_SPEED * delta

	# Dessine la corde depuis le Marker2D
	rope.clear_points()
	rope.add_point(to_local(grapple_origin.global_position))
	rope.add_point(to_local(grapple_point))

	if global_position.distance_to(grapple_point) < 20.0:
		_release_grapple()
