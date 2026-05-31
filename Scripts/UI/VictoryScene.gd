extends Control

var leaderboard_manager: Node
var game_manager: Node

func _ready() -> void:
	leaderboard_manager = get_tree().get_first_child_in_group("leaderboard")
	game_manager = get_tree().get_first_child_in_group("game_manager")
	
	$VBoxContainer/ContinueButton.pressed.connect(_on_continue_pressed)
	$VBoxContainer/MenuButton.pressed.connect(_on_menu_pressed)
	
	if game_manager:
		$VBoxContainer/ScoreLabel.text = "Final Score: %d" % game_manager.score


func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/MainMenuScene.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/MainMenuScene.tscn")
