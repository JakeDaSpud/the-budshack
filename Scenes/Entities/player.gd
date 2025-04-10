extends CharacterBody3D

const _SPEED : float = 5;

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
	$Camera3D.fov = CONFIG.CAMERA_FOV;

func _physics_process(delta):
	_handle_pause();
	_handle_interact();
	_handle_movement(delta);

func _input(event):
	if (event.get_class() == "InputEventMouseMotion"):
		#print_debug("yeppp mouse");
		rotate_y(-event.relative.x * CONFIG.MOUSE_CAMERA_SENSITIVITY);
		$Camera3D.rotate_x(-event.relative.y * CONFIG.MOUSE_CAMERA_SENSITIVITY);

func _handle_movement(delta : float):
	var input_dir = Input.get_vector("Move_Left", "Move_Right", "Move_Forward", "Move_Back");
	
	if (input_dir != Vector2.ZERO):
		var direction = self.transform.basis * Vector3(input_dir.x, 0, input_dir.y).normalized();
		
		velocity = direction * _SPEED;
		
		move_and_slide();

func _handle_pause():
	if (Input.is_action_pressed("Pause")):
		print_debug("Quitting");
		get_tree().quit();

func _handle_interact():
	if (Input.is_action_just_pressed("Interact")):
		print_debug("Interact Pressed");
