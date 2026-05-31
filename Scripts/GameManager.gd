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
var game_speed = 1.0
var score = 0
var customers_served = 0
var non_humans_detected = 0

var customer_spawn_timer = 0.0
var smiling_man_spawned = false
var smiling_man_timer = 0.0
var inspector_spawned = false
var inspector_active = false
var inspector_timer = 0.0
var inspector_outside_check_timer = 0.0

var customers = []
var player_ref: Node3D
var hud_ref: Node
var audio_manager: Node
var difficulty_manager: Node
var customer_manager: Node
var leaderboard_manager: Node

signal time_changed(hours: int, minutes: int)
signal customer_spawned(customer_type: String)
signal smiling_man_appeared
signal inspector_arrived
signal game_over(reason: String)
signal victory

func _ready() -> void:
	add_to_group("game_manager")
	player_ref = get_parent().get_node("Player")
	hud_ref = get_parent().get_node("HUD")
	audio_manager = get_tree().get_first_child_in_group("audio")
	difficulty_manager = get_tree().get_first_child_in_group("difficulty")
	customer_manager = get_tree().get_first_child_in_group("customers")
	leaderboard_manager = get_tree().get_first_child_in_group("leaderboard")
	
	initialize_inventory()
	setup_difficulty()
	setup_audio()


func setup_difficulty() -> void:
	if difficulty_manager:
		game_speed = difficulty_manager.get_setting("game_speed")


func setup_audio() -> void:
	if audio_manager:
		var sound_effects = SoundEffects.new()
		add_child(sound_effects)
		sound_effects.play_background_music()
		sound_effects.play_ambient()

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
		hud_ref.update_score(score)
	
	# Spawn customers with difficulty modifier
	var spawn_interval = CUSTOMER_SPAWN_INTERVAL if not difficulty_manager else difficulty_manager.get_setting("customer_spawn_interval")
	customer_spawn_timer += delta
	if customer_spawn_timer >= spawn_interval:
		spawn_customer()
		customer_spawn_timer = 0.0
	
	# Smiling Man encounter at 3 AM
	if current_hours >= int(SMILING_MAN_SPAWN_TIME) and not smiling_man_spawned:
		smiling_man_spawned = true
		spawn_smiling_man()
	
	var window = SMILING_MAN_WINDOW if not difficulty_manager else difficulty_manager.get_setting("smiling_man_window")
	if smiling_man_spawned and smiling_man_timer < window:
		smiling_man_timer += delta
		if smiling_man_timer >= window:
			end_game("Smiling Man caught you. You're dead.")
			return
	
	# Inspector spawn
	var inspector_prob = 0.001 if not difficulty_manager else difficulty_manager.get_setting("inspector_probability")
	if not inspector_spawned and current_hours > 1 and current_hours < 5:
		if randf() < inspector_prob:
			inspector_spawned = true
			inspector_active = true
			spawn_inspector()
			inspector_timer = 0.0
	
	if inspector_active:
		inspector_timer += delta
		inspector_outside_check_timer += delta
		
		if inspector_outside_check_timer >= CAMERA_CHECK_INTERVAL:
			if not is_player_inside():
				end_game("Inspector found you outside. You're fired!")
				return
			inspector_outside_check_timer = 0.0
		
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
	var non_human_ratio = 0.2 if not difficulty_manager else difficulty_manager.get_setting("non_human_ratio")
	var customer_type = customer_manager.get_random_customer_type(non_human_ratio) if customer_manager else "HUMAN_CUSTOMER"
	customer_spawned.emit(customer_type)
	
	if audio_manager:
		var sound_effects = SoundEffects.new()
		if customer_manager and customer_manager.is_non_human(customer_type):
			sound_effects.play_sound("camera_detect", 0.7)
			non_humans_detected += 1
			print("Non-human detected: ", customer_type)
		else:
			print("Customer spawned: ", customer_type)


func spawn_smiling_man() -> void:
	smiling_man_appeared.emit()
	if audio_manager:
		var sound_effects = SoundEffects.new()
		sound_effects.play_sound("smiling_man", 0.9)
	print("Smiling Man appeared at the Soda Machine!")


func spawn_inspector() -> void:
	inspector_arrived.emit()
	if audio_manager:
		var sound_effects = SoundEffects.new()
		sound_effects.play_sound("inspector", 0.8)
	print("Inspector arrived!")


func is_player_inside() -> bool:
	if not player_ref:
		return true
	var player_pos = player_ref.global_position
	return abs(player_pos.x) < 10 and abs(player_pos.z) < 10


func complete_smiling_man_interaction() -> void:
	smiling_man_timer = SMILING_MAN_WINDOW + 1.0
	score += 500
	if audio_manager:
		var sound_effects = SoundEffects.new()
		sound_effects.play_sound("victory", 0.7)
	print("You survived the Smiling Man!")


func add_ingredient(ingredient_type: String) -> void:
	if ingredient_type in inventory:
		inventory[ingredient_type] += 1
		if audio_manager:
			var sound_effects = SoundEffects.new()
			sound_effects.play_sound("pickup", 0.6)
		if hud_ref:
			hud_ref.update_inventory(inventory)


func remove_ingredient(ingredient_type: String) -> void:
	if ingredient_type in inventory and inventory[ingredient_type] > 0:
		inventory[ingredient_type] -= 1
		if hud_ref:
			hud_ref.update_inventory(inventory)


func serve_taco(recipe_correct: bool) -> void:
	if recipe_correct:
		customers_served += 1
		score += 100
		if audio_manager:
			var sound_effects = SoundEffects.new()
			sound_effects.play_sound("serve", 0.7)
		print("Correct recipe! Customer satisfied.")
	else:
		end_game("Wrong recipe! Customer called health inspector.")


func detect_non_human_on_camera(detected: bool) -> void:
	if detected:
		if audio_manager:
			var sound_effects = SoundEffects.new()
			sound_effects.play_sound("alarm", 0.8)
		print("MONSTER DETECTED on security camera!")


func end_game(reason: String) -> void:
	game_running = false
	var time_survived = game_time_minutes / 60.0
	
	if reason == "victory":
		victory.emit()
		score += int(time_survived * 50)
		if leaderboard_manager:
			var difficulty_name = difficulty_manager.get_difficulty_name() if difficulty_manager else "NORMAL"
			leaderboard_manager.add_score("Player", score, difficulty_name, time_survived)
		if audio_manager:
			var sound_effects = SoundEffects.new()
			sound_effects.play_sound("victory", 0.9)
		print("VICTORY! You survived until 6 AM! Score: ", score)
		get_tree().change_scene_to_file("res://Scenes/UI/VictoryScene.tscn")
	else:
		game_over.emit(reason)
		if audio_manager:
			var sound_effects = SoundEffects.new()
			sound_effects.play_sound("gameover", 0.9)
		print("GAME OVER: ", reason)
		get_tree().change_scene_to_file("res://Scenes/UI/GameOverScene.tscn")
