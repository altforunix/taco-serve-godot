extends CharacterBody3D

const SPEED = 7.0
const MOUSE_SENSITIVITY = 0.003
const INTERACTION_RANGE = 3.0

var camera: Camera3D
var raycast: RayCast3D
var game_manager: Node
var hud: Node
var is_hiding = false

func _ready() -> void:
	camera = $Camera3D
	raycast = $Camera3D/RayCast3D
	game_manager = get_parent().get_node("GameManager")
	hud = get_parent().get_node("HUD")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta: float) -> void:
	handle_movement(delta)
	handle_interaction()
	handle_hiding()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
			camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)


func handle_movement(delta: float) -> void:
	var input_vec = Vector3.ZERO
	
	if Input.is_action_pressed("ui_up"):
		input_vec.z -= 1
	if Input.is_action_pressed("ui_down"):
		input_vec.z += 1
	if Input.is_action_pressed("ui_left"):
		input_vec.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_vec.x += 1
	
	if input_vec != Vector3.ZERO:
		input_vec = input_vec.normalized()
		var forward = -global_transform.basis.z
		var right = global_transform.basis.x
		input_vec = (forward * input_vec.z + right * input_vec.x).normalized()
		velocity.x = input_vec.x * SPEED
		velocity.z = input_vec.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	velocity.y += -9.8 * delta
	move_and_slide()


func handle_interaction() -> void:
	if Input.is_action_just_pressed("ui_accept"):  # E key
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider and collider.has_method("interact"):
				collider.interact(self)


func handle_hiding() -> void:
	if Input.is_action_just_pressed("ui_focus_next"):  # Tab key
		toggle_hide()


func toggle_hide() -> void:
	is_hiding = !is_hiding
	if hud:
		var black_screen = hud.get_node("Control/BlackScreen")
		if black_screen:
			black_screen.visible = is_hiding


func add_to_inventory(ingredient: String) -> void:
	if game_manager:
		game_manager.add_ingredient(ingredient)
