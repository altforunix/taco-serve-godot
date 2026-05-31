extends Control

var game_manager: Node

func _ready() -> void:
	game_manager = get_tree().get_first_child_in_group("game_manager")
	
	var restart_button = $VBoxContainer/RestartButton
	var menu_button = $VBoxContainer/MenuButton
	var reason_label = $VBoxContainer/Reason
	var score_label = $VBoxContainer/ScoreLabel
	
	restart_button.pressed.connect(_on_restart_pressed)
	menu_button.pressed.connect(_on_menu_pressed)
	
	if game_manager:
		score_label.text = "Score: %d" % game_manager.score


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/DifficultySelectScene.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/MainMenuScene.tscn")
