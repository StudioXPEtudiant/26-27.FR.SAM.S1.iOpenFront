extends Node3D

# Récupération des éléments
@onready var rotation_x = $CameraRotationX
@onready var zoom_pivot = $CameraRotationX/CameraZoomPivot
@onready var camera = $CameraRotationX/CameraZoomPivot/Camera3D

# Variables déplacement
var move_speed = 10.0
var move_target: Vector3

# Variables rotation
var rotate_keys_speed = 60.0
var rotate_keys_target: float

# Variables zoom
var zoom_speed = 2.5
var zoom_target: float
var min_zoom = -0.0
var max_zoom = 100.0


func _ready() -> void:
	move_target = position
	rotate_keys_target = rotation.y
	zoom_target = camera.position.z


func _process(delta: float) -> void:

	# Récupération des touches
	var input_direction = Input.get_vector("left", "right", "up", "down")
	var rotate_keys = Input.get_axis("rotate_left", "rotate_right")

	# Calcul de la direction
	var movement_direction = (
		transform.basis * Vector3(input_direction.x, 0, input_direction.y)
	).normalized()

	# Détection du zoom
	var zoom_dir = (
		int(Input.is_action_just_pressed("camera_zoom_out"))
		- int(Input.is_action_just_pressed("camera_zoom_in"))
	)

	# Déplacement
	move_target += movement_direction * move_speed * delta

	# Rotation
	rotate_keys_target += rotate_keys * deg_to_rad(rotate_keys_speed) * delta

	# Zoom
	zoom_target += zoom_dir * zoom_speed
	zoom_target = clamp(zoom_target, min_zoom, max_zoom)

	# Fluidité
	var smoothness = 1.0 - exp(-10.0 * delta)

	# Application du déplacement
	position = position.lerp(move_target, smoothness)

	# Application de la rotation
	rotation.y = lerp_angle(rotation.y, rotate_keys_target, smoothness)

	# Application du zoom
	camera.position.z = lerp(camera.position.z, zoom_target, smoothness)
