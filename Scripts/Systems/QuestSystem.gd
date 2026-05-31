extends Node

class_name QuestSystem

enum QUEST_STATE { NOT_STARTED, IN_PROGRESS, COMPLETED, FAILED }

var quests: Dictionary = {}
var active_quests: Array = []
var completed_quests: Array = []

signal quest_started(quest_id: String)
signal quest_updated(quest_id: String, progress: float)
signal quest_completed(quest_id: String, reward: int)
signal quest_failed(quest_id: String)

func _ready() -> void:
	name = "QuestSystem"
	add_to_group("quests")
	initialize_quests()

func initialize_quests() -> void:
	quests = {
		"first_serve": {
			"title": "Serve Your First Taco",
			"description": "Prepare and serve a taco to a customer",
			"state": QUEST_STATE.NOT_STARTED,
			"progress": 0.0,
			"reward": 100,
			"required_progress": 1.0
		},
		"survive_smiling_man": {
			"title": "Survive the Smiling Man",
			"description": "Interact with the Smiling Man at 3 AM",
			"state": QUEST_STATE.NOT_STARTED,
			"progress": 0.0,
			"reward": 500,
			"required_progress": 1.0
		},
		"survive_inspector": {
			"title": "Escape Inspector Detection",
			"description": "Evade the inspector check successfully",
			"state": QUEST_STATE.NOT_STARTED,
			"progress": 0.0,
			"reward": 300,
			"required_progress": 1.0
		},
		"serve_five": {
			"title": "Efficient Service",
			"description": "Serve 5 customers correctly",
			"state": QUEST_STATE.NOT_STARTED,
			"progress": 0.0,
			"reward": 250,
			"required_progress": 5.0
		},
		"detect_entity": {
			"title": "See the Unseen",
			"description": "Detect 3 non-human entities",
			"state": QUEST_STATE.NOT_STARTED,
			"progress": 0.0,
			"reward": 200,
			"required_progress": 3.0
		}
	}

func start_quest(quest_id: String) -> void:
	if quest_id in quests:
		quests[quest_id]["state"] = QUEST_STATE.IN_PROGRESS
		active_quests.append(quest_id)
		quest_started.emit(quest_id)

func update_quest_progress(quest_id: String, increment: float) -> void:
	if quest_id in quests:
		quests[quest_id]["progress"] += increment
		var quest_data = quests[quest_id]
		
		if quest_data["progress"] >= quest_data["required_progress"] and quest_data["state"] == QUEST_STATE.IN_PROGRESS:
			complete_quest(quest_id)
		else:
			quest_updated.emit(quest_id, quest_data["progress"] / quest_data["required_progress"])

func complete_quest(quest_id: String) -> void:
	if quest_id in quests:
		quests[quest_id]["state"] = QUEST_STATE.COMPLETED
		completed_quests.append(quest_id)
		active_quests.erase(quest_id)
		var reward = quests[quest_id]["reward"]
		quest_completed.emit(quest_id, reward)

func fail_quest(quest_id: String) -> void:
	if quest_id in quests:
		quests[quest_id]["state"] = QUEST_STATE.FAILED
		active_quests.erase(quest_id)
		quest_failed.emit(quest_id)

func get_active_quests() -> Array:
	return active_quests.duplicate()

func get_quest_info(quest_id: String) -> Dictionary:
	return quests.get(quest_id, {})
