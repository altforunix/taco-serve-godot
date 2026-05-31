extends Control

func _ready() -> void:
	$VBoxContainer/PlayButton.pressed.connect(_on_play_pressed)
	$VBoxContainer/SettingsButton.pressed.connect(_on_settings_pressed)
	$VBoxContainer/LeaderboardButton.pressed.connect(_on_leaderboard_pressed)
	$VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/DifficultySelectScene.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/SettingsScene.tscn")


func _on_leaderboard_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/LeaderboardScene.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
