extends Control

var leaderboard_manager: Node
var leaderboard_list: ItemList

func _ready() -> void:
	leaderboard_manager = get_tree().get_first_child_in_group("leaderboard")
	leaderboard_list = $VBoxContainer/LeaderboardList
	$VBoxContainer/BackButton.pressed.connect(_on_back_pressed)
	display_leaderboard()


func display_leaderboard() -> void:
	if not leaderboard_manager:
		return
	
	var leaderboard = leaderboard_manager.get_leaderboard()
	leaderboard_list.clear()
	
	if leaderboard.is_empty():
		leaderboard_list.add_item("No scores yet. Be the first to set a record!")
		return
	
	for i in range(leaderboard.size()):
		var entry = leaderboard[i]
		var rank = i + 1
		var score = entry["score"]
		var name = entry["name"]
		var difficulty = entry["difficulty"]
		var time_survived = entry["time_survived"]
		
		var display_text = "%d. [%s] %s - Score: %d (%.1f hours)" % [rank, difficulty, name, score, time_survived]
		leaderboard_list.add_item(display_text)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/DifficultySelectScene.tscn")
