extends Node

class_name DialogueSystem

var dialogues: Dictionary = {}
var current_dialogue: String = ""
var dialogue_index: int = 0

signal dialogue_started(character: String)
signal dialogue_line_displayed(text: String)
signal dialogue_ended(character: String)
signal dialogue_choice_needed(choices: Array)

func _ready() -> void:
	name = "DialogueSystem"
	add_to_group("dialogue")
	initialize_dialogues()

func initialize_dialogues() -> void:
	dialogues = {
		"smiling_man_greeting": {
			"character": "Smiling Man",
			"lines": [
				"You've made a grave mistake...",
				"Working at night, are we?",
				"I do love... tacos.",
				"Will you... serve me?"
			]
		},
		"inspector_greeting": {
			"character": "Inspector",
			"lines": [
				"Health inspection time!",
				"I'll be checking everything.",
				"You better be clean."
			]
		},
		"customer_greeting": {
			"character": "Customer",
			"lines": [
				"I'll take a taco, please.",
				"Make it fresh!"
			]
		},
		"entity_whisper": {
			"character": "Entity",
			"lines": [
				"...",
				"[INCOMPREHENSIBLE WHISPERS]",
				"*static noise*"
			]
		}
	}

func start_dialogue(dialogue_id: String) -> void:
	if dialogue_id in dialogues:
		current_dialogue = dialogue_id
		dialogue_index = 0
		var character = dialogues[dialogue_id]["character"]
		dialogue_started.emit(character)
		display_next_line()

func display_next_line() -> void:
	if current_dialogue not in dialogues:
		return
	
	var dialogue_data = dialogues[current_dialogue]
	if dialogue_index < dialogue_data["lines"].size():
		var line = dialogue_data["lines"][dialogue_index]
		dialogue_line_displayed.emit(line)
		dialogue_index += 1
	else:
		end_dialogue()

func end_dialogue() -> void:
	var character = dialogues[current_dialogue]["character"]
	dialogue_ended.emit(character)
	current_dialogue = ""
	dialogue_index = 0

func get_dialogue(dialogue_id: String) -> Dictionary:
	return dialogues.get(dialogue_id, {})
