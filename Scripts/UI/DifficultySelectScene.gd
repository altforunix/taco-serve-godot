extends Control

var difficulty_manager: Node

func _ready() -> void:
	diffculty_manager = get_tree().get_first_child_in_group("difficulty")
	
	$VBoxContainer/EasyButton.pressed.connect(_on_easy_pressed)
	$VBoxContainer/NormalButton.pressed.connect(_on_normal_pressed)
	$VBoxContainer/HardButton.pressed.connect(_on_hard_pressed)
	$VBoxContainer/NightmareButton.pressed.connect(_on_nightmare_pressed)
	$VBoxContainer/LeaderboardButton.pressed.connect(_on_leaderboard_pressed)


func _on_easy_pressed() -> void:
	if difficulty_manager:
		difficulty_manager.set_difficulty(0)  # EASY
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")


func _on_normal_pressed() -> void:
	if difficulty_manager:
		difficulty_manager.set_difficulty(1)  # NORMAL
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")


func _on_hard_pressed() -> void:
	if difficulty_manager:
		difficulty_manager.set_difficulty(2)  # HARD
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")


func _on_nightmare_pressed() -> void:
	if difficulty_manager:
		difficulty_manager.set_difficulty(3)  # NIGHTMARE
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")


func _on_leaderboard_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/LeaderboardScene.tscn")
