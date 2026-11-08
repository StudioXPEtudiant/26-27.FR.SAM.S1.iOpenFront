extends Node3D

#onready
@onready var rotation_x = $CameraRotationX
@onready var zoom_pivot = $CameraRotationX/CameraZoomPivot
@onready var camera = $CameraRotationX/CameraZoomPivot/Camera3D

#variables
var move_speed = 0.6 
var move_target: Vector3
func _ready() -> void:
	move_target = position



func _process(delta: float) -> void:
	# get input directions
	var input_direction = Input.get_vector("left", "right","up", "down")
	var movement_direction = (transform.basis * Vector3(input_direction.x, 0,input_direction.y)).normalized()
	#set movement targets
	move_target += move_speed * movement_direction
	#lerp to movement targets
	position = lerp(position, move_target, 0.05)
