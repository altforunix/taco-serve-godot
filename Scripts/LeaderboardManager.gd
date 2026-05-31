extends Node

const LEADERBOARD_FILE = "user://taco_serve_leaderboard.json"
const MAX_ENTRIES = 10

var leaderboard: Array = []

func _ready() -> void:
	name = "LeaderboardManager"
	add_to_group("leaderboard")
	load_leaderboard()


func load_leaderboard() -> void:
	if ResourceLoader.exists(LEADERBOARD_FILE):
		var file = FileAccess.open(LEADERBOARD_FILE, FileAccess.READ)
		if file:
			var json = JSON.new()
			var data = json.parse(file.get_as_text())
			if data is Array:
				leaderboard = data
		else:
			leaderboard = []
	else:
		leaderboard = []


func save_leaderboard() -> void:
	var json = JSON.stringify(leaderboard)
	var file = FileAccess.open(LEADERBOARD_FILE, FileAccess.WRITE)
	if file:
		file.store_string(json)


func add_score(player_name: String, score: int, difficulty: String, time_survived: float) -> bool:
	var entry = {
		"name": player_name,
		"score": score,
		"difficulty": difficulty,
		"time_survived": time_survived,
		"date": Time.get_datetime_string_from_system()
	}
	
	leaderboard.append(entry)
	leaderboard.sort_custom(func(a, b): return a["score"] > b["score"])
	
	while leaderboard.size() > MAX_ENTRIES:
		leaderboard.pop_back()
	
	save_leaderboard()
	
	# Return true if in top 10
	return leaderboard.find(entry) < MAX_ENTRIES


func get_leaderboard() -> Array:
	return leaderboard.duplicate()


func get_rank(player_name: String) -> int:
	for i in range(leaderboard.size()):
		if leaderboard[i]["name"] == player_name:
			return i + 1
	return -1


func clear_leaderboard() -> void:
	leaderboard.clear()
	save_leaderboard()
