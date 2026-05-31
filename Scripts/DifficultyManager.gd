extends Node

enum DIFFICULTY { EASY, NORMAL, HARD, NIGHTMARE }

var current_difficulty = DIFFICULTY.NORMAL

var difficulty_settings = {
	DIFFICULTY.EASY: {
		"customer_spawn_interval": 60.0,
		"smiling_man_window": 8.0,
		"inspector_probability": 0.0005,
		"non_human_ratio": 0.1,
		"game_speed": 0.5,
		"ingredient_spawn_rate": 1.2
	},
	DIFFICULTY.NORMAL: {
		"customer_spawn_interval": 45.0,
		"smiling_man_window": 5.0,
		"inspector_probability": 0.001,
		"non_human_ratio": 0.2,
		"game_speed": 1.0,
		"ingredient_spawn_rate": 1.0
	},
	DIFFICULTY.HARD: {
		"customer_spawn_interval": 30.0,
		"smiling_man_window": 3.0,
		"inspector_probability": 0.0015,
		"non_human_ratio": 0.4,
		"game_speed": 1.5,
		"ingredient_spawn_rate": 0.8
	},
	DIFFICULTY.NIGHTMARE: {
		"customer_spawn_interval": 20.0,
		"smiling_man_window": 2.0,
		"inspector_probability": 0.002,
		"non_human_ratio": 0.6,
		"game_speed": 2.0,
		"ingredient_spawn_rate": 0.5
	}
}

func set_difficulty(difficulty: int) -> void:
	current_difficulty = difficulty


func get_setting(setting_name: String) -> float:
	return difficulty_settings[current_difficulty].get(setting_name, 0.0)


func get_difficulty_name() -> String:
	match current_difficulty:
		DIFFICULTY.EASY: return "EASY"
		DIFFICULTY.NORMAL: return "NORMAL"
		DIFFICULTY.HARD: return "HARD"
		DIFFICULTY.NIGHTMARE: return "NIGHTMARE"
		_: return "UNKNOWN"
