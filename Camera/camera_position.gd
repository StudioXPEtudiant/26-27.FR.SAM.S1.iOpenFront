extends Node3D

# Récupération des éléments
@onready var rotation_x = $CameraRotationX
@onready var zoom_pivot = $CameraRotationX/CameraZoomPivot
@onready var camera = $CameraRotationX/CameraZoomPivot/Camera3D

# Variables
var move_speed = 5.0
var move_target: Vector3


func _ready() -> void:
	move_target = position


func _process(delta: float) -> void:

	# Récupération des touches
	var input_direction = Input.get_vector("left", "right", "up", "down")

	# Calcul de la direction
	var movement_direction = (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()

	# Déplacement de la cible
	move_target += movement_direction * move_speed * delta

	# Déplacement fluide
	var smoothness = 1.0 - exp(-10.0 * delta)
	position = position.lerp(move_target, smoothness)
