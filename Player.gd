extends CharacterBody3D

enum PlayerStates {NORMAL, DIALOGUE}
var player_state = PlayerStates.NORMAL

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var look_direction: Vector2
@onready var camera = $Camera3D
var camera_sensitivity = 50

var capMouse = true

func _process(delta):
	# Toggle Capture Mouse
	if Input.is_action_just_pressed("pause"):
		capMouse = !capMouse
	
		if capMouse:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	if player_state == PlayerStates.NORMAL:
		# Get the input direction and handle the movement/deceleration.
		var input_dir = Input.get_vector("left", "right", "forward", "backward")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
				
		_rotate_camera(delta)
		move_and_slide()

func _input(event: InputEvent):
	if player_state == PlayerStates.NORMAL:
		# Mouse Input (Looking)
		if event is InputEventMouseMotion: look_direction = event.relative * 0.01

func _rotate_camera(delta: float, sensitivity_y_mod: float = .6, sensitivity_x_mod: float = .6):
	if player_state == PlayerStates.NORMAL:
		# Joypad Input (Looking) - 
		var input = Input.get_vector("look_left", "look_right", "look_down", "look_up")
		input.y *= -1
		look_direction += input * .1
		
		# Left-Right looking
		rotation.y -= look_direction.x * camera_sensitivity * sensitivity_x_mod * delta
		
		# Up-Down looking
		camera.rotation.x = clamp(camera.rotation.x - look_direction.y * camera_sensitivity * sensitivity_y_mod * delta, -1.5, 1.5)
		
		# Default look position
		look_direction = Vector2.ZERO
