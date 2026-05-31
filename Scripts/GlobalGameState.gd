extends Node

var game_data = {
	"time_elapsed": 0.0,
	"customers_served": 0,
	"non_humans_encountered": 0,
	"smiling_man_survived": false,
	"inspector_passed": false
}

func _ready() -> void:
	name = "GlobalGameState"
	add_to_group("global")


func record_customer_served() -> void:
	game_data["customers_served"] += 1


func record_non_human_encounter() -> void:
	game_data["non_humans_encountered"] += 1


func record_smiling_man_survived() -> void:
	game_data["smiling_man_survived"] = true


func record_inspector_passed() -> void:
	game_data["inspector_passed"] = true
