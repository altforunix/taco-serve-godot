extends Node

const GAME_START_HOUR = 0  # 12 AM
const GAME_END_HOUR = 6    # 6 AM
const CUSTOMER_SPAWN_INTERVAL = 45.0
const SMILING_MAN_SPAWN_TIME = 3.0  # 3 AM
const SMILING_MAN_WINDOW = 5.0
const INSPECTOR_WINDOW = 7.0
const CAMERA_CHECK_INTERVAL = 10.0

var game_time_minutes = 0.0
var game_running = true
var inventory = {}
var game_speed = 1.0  # Adjust for faster/slower gameplay

var customer_spawn_timer = 0.0
var smiling_man_spawned = false
var smiling_man_timer = 0.0
var inspector_spawned = false
var inspector_active = false
var inspector_timer = 0.0
var inspector_outside_check_timer = 0.0

var customers = []  # Stores active customers
var non_human_detected = false
var player_ref: Node3D
var hud_ref: Node

signal time_changed(hours: int, minutes: int)
signal customer_spawned(customer_type: String)
signal smiling_man_appeared
signal inspector_arrived
signal game_over(reason: String)
signal victory

func _ready() -> void:
	player_ref = get_parent().get_node("Player")
	hud_ref = get_parent().get_node("HUD")
	initialize_inventory()


func _process(delta: float) -> void:
	if not game_running:
		return
	
	# Update game time
	game_time_minutes += delta * 60.0 * game_speed
	var current_hours = int(game_time_minutes / 60.0) + GAME_START_HOUR
	var current_minutes = int(game_time_minutes) % 60
	
	# Check for victory condition (6 AM)
	if current_hours >= GAME_END_HOUR:
		end_game("victory")
		return
	
	# Update HUD
	if hud_ref:
		hud_ref.update_time(current_hours, current_minutes)
	
	# Spawn customers
	customer_spawn_timer += delta
	if customer_spawn_timer >= CUSTOMER_SPAWN_INTERVAL:
		spawn_customer()
		customer_spawn_timer = 0.0
	
	# Smiling Man encounter at 3 AM
	if current_hours >= int(SMILING_MAN_SPAWN_TIME) and not smiling_man_spawned:
		smiling_man_spawned = true
		spawn_smiling_man()
	
	if smiling_man_spawned and not smiling_man_timer >= SMILING_MAN_WINDOW:
		smiling_man_timer += delta
		if smiling_man_timer >= SMILING_MAN_WINDOW:
			# Smiling Man kills player if interaction not completed
			end_game("Smiling Man caught you.")
			return
	
	# Inspector spawn at random time (after 1 AM, before 5 AM)
	if not inspector_spawned and current_hours > 1 and current_hours < 5:
		if randf() < 0.001:  # Very low chance per frame
			inspector_spawned = true
			inspector_active = true
			spawn_inspector()
			inspector_timer = 0.0
	
	if inspector_active:
		inspector_timer += delta
		inspector_outside_check_timer += delta
		
		# Check if player is outside every interval
		if inspector_outside_check_timer >= CAMERA_CHECK_INTERVAL:
			if not is_player_inside():
				end_game("Inspector found you outside. You're fired!")
				return
			inspector_outside_check_timer = 0.0
		
		# Inspector leaves after 7 seconds
		if inspector_timer >= INSPECTOR_WINDOW:
			inspector_active = false


func initialize_inventory() -> void:
	inventory = {
		"shell": 0,
		"meat": 0,
		"cheese": 0,
		"lettuce": 0
	}


func spawn_customer() -> void:
	var customer_type = "HUMAN" if randf() < 0.8 else "NON_HUMAN"
	customer_spawned.emit(customer_type)
	print("Customer spawned: ", customer_type)


func spawn_smiling_man() -> void:
	smiling_man_appeared.emit()
	print("Smiling Man appeared at the Soda Machine!")


func spawn_inspector() -> void:
	inspector_arrived.emit()
	print("Inspector arrived!")


func is_player_inside() -> bool:
	if not player_ref:
		return true
	# Check if player is within building bounds (rough check)
	var player_pos = player_ref.global_position
	return abs(player_pos.x) < 10 and abs(player_pos.z) < 10


func complete_smiling_man_interaction() -> void:
	smiling_man_timer = SMILING_MAN_WINDOW + 1.0  # Mark as completed
	print("You survived the Smiling Man!")


func add_ingredient(ingredient_type: String) -> void:
	if ingredient_type in inventory:
		inventory[ingredient_type] += 1
		if hud_ref:
			hud_ref.update_inventory(inventory)


func remove_ingredient(ingredient_type: String) -> void:
	if ingredient_type in inventory and inventory[ingredient_type] > 0:
		inventory[ingredient_type] -= 1
		if hud_ref:
			hud_ref.update_inventory(inventory)


func serve_taco(recipe_correct: bool) -> void:
	if recipe_correct:
		print("Correct recipe! Customer satisfied.")
		# Award points or progress
	else:
		end_game("Wrong recipe! Customer called health inspector.")


func detect_non_human_on_camera(detected: bool) -> void:
	non_human_detected = detected
	if detected:
		print("MONSTER DETECTED on security camera!")


func end_game(reason: String) -> void:
	game_running = false
	if reason == "victory":
		victory.emit()
		print("VICTORY! You survived until 6 AM!")
		get_tree().change_scene_to_file("res://Scenes/UI/VictoryScene.tscn")
	else:
		game_over.emit(reason)
		print("GAME OVER: ", reason)
		get_tree().change_scene_to_file("res://Scenes/UI/GameOverScene.tscn")
