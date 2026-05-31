extends Node

class_name AchievementSystem

var achievements: Dictionary = {}
var unlocked_achievements: Array = []

signal achievement_unlocked(achievement_id: String, title: String)

func _ready() -> void:
	name = "AchievementSystem"
	add_to_group("achievements")
	initialize_achievements()

func initialize_achievements() -> void:
	achievements = {
		"first_blood": {
			"title": "First Serve",
			"description": "Serve your first taco",
			"icon": "🌮",
			"unlocked": false
		},
		"speed_demon": {
			"title": "Speed Demon",
			"description": "Complete HARD difficulty without failing",
			"icon": "⚡",
			"unlocked": false
		},
		"nightmare_survivor": {
			"title": "Nightmare Survivor",
			"description": "Survive NIGHTMARE difficulty",
			"icon": "💀",
			"unlocked": false
		},
		"entity_whisperer": {
			"title": "Entity Whisperer",
			"description": "Encounter all 5 entity types",
			"icon": "👽",
			"unlocked": false
		},
		"perfectionist": {
			"title": "Perfectionist",
			"description": "Achieve 1000+ score",
			"icon": "✨",
			"unlocked": false
		},
		"smiling_friend": {
			"title": "Smiling Friend",
			"description": "Successfully interact with Smiling Man",
			"icon": "😊",
			"unlocked": false
		},
		"inspector_evader": {
			"title": "Inspector Evader",
			"description": "Evade inspector 3 times",
			"icon": "🎩",
			"unlocked": false
		},
		"leaderboard_king": {
			"title": "Leaderboard King",
			"description": "Reach rank #1 on leaderboard",
			"icon": "👑",
			"unlocked": false
		}
	}

func unlock_achievement(achievement_id: String) -> void:
	if achievement_id in achievements and not achievements[achievement_id]["unlocked"]:
		achievements[achievement_id]["unlocked"] = true
		unlocked_achievements.append(achievement_id)
		var title = achievements[achievement_id]["title"]
		achievement_unlocked.emit(achievement_id, title)

func is_unlocked(achievement_id: String) -> bool:
	return achievements.get(achievement_id, {}).get("unlocked", false)

func get_unlocked_achievements() -> Array:
	return unlocked_achievements.duplicate()

func get_total_achievements() -> int:
	return achievements.size()

func get_completion_percentage() -> float:
	if achievements.is_empty():
		return 0.0
	return (unlocked_achievements.size() / float(achievements.size())) * 100.0
