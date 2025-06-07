extends CharacterBody3D

@export var speed: float = 5.0
@export var jump_velocity: float = 7.0
@export var gravity: float = 20.0
@export var mouse_sensitivity: float = 0.3

var camera_pivot: Node3D
var mainCamera: Camera3D
var ThirdCamera: Camera3D
var using_first_person: bool = true

func _ready():
	camera_pivot = $CameraPivot
	mainCamera = camera_pivot.get_node("MainCamera")
	ThirdCamera = camera_pivot.get_node("ThirdPersonCamera")

	# Activa solo la cámara principal
	mainCamera.current = true
	ThirdCamera.current = false

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# Rotación horizontal del jugador
		rotate_y(-event.relative.x * mouse_sensitivity * 0.01)

		# Rotación vertical de la cámara
		camera_pivot.rotate_x(-event.relative.y * mouse_sensitivity * 0.01)
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, deg_to_rad(-80), deg_to_rad(80))

func _physics_process(delta):
	# Movimiento
	# print(transform.origin)
	var dir = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		dir -= transform.basis.z
	if Input.is_action_pressed("move_back"):
		dir += transform.basis.z
	if Input.is_action_pressed("move_left"):
		dir -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		dir += transform.basis.x

	dir.y = 0
	dir = dir.normalized()

	velocity.x = dir.x * speed
	velocity.z = dir.z * speed

	# Gravedad y salto
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity

	move_and_slide()

	# Cambio de cámara
	if Input.is_action_just_pressed("change_camera"):
		changeCamera()

func changeCamera():
	using_first_person = !using_first_person
	mainCamera.current = using_first_person
	ThirdCamera.current = not using_first_person
