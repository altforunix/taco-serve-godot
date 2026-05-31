extends Node

class_name AnalyticsSystem

var session_data: Dictionary = {}
var event_log: Array = []

signal event_recorded(event_name: String, data: Dictionary)

func _ready() -> void:
	name = "AnalyticsSystem"
	add_to_group("analytics")
	start_session()

func start_session() -> void:
	session_data = {
		"session_id": randi(),
		"start_time": Time.get_ticks_msec(),
		"game_version": "3.0",
		"player_data": {}
	}

func record_event(event_name: String, data: Dictionary = {}) -> void:
	var event = {
		"name": event_name,
		"timestamp": Time.get_ticks_msec(),
		"data": data
	}
	event_log.append(event)
	event_recorded.emit(event_name, data)

func record_game_completion(difficulty: String, score: int, time_survived: float) -> void:
	record_event("game_completed", {
		"difficulty": difficulty,
		"score": score,
		"time_survived": time_survived
	})

func record_achievement_unlocked(achievement_id: String) -> void:
	record_event("achievement_unlocked", {"achievement_id": achievement_id})

func record_customer_served(customer_type: String, recipe_correct: bool) -> void:
	record_event("customer_served", {
		"customer_type": customer_type,
		"recipe_correct": recipe_correct
	})

func get_session_stats() -> Dictionary:
	var duration = (Time.get_ticks_msec() - session_data["start_time"]) / 1000.0
	return {
		"session_id": session_data["session_id"],
		"duration_seconds": duration,
		"total_events": event_log.size()
	}
