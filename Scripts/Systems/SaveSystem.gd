extends Node

class_name SaveSystem

const SAVE_DIR = "user://taco_serve_saves/"

var current_save: Dictionary = {}

signal game_saved(slot: int)
signal game_loaded(slot: int)
signal save_deleted(slot: int)

func _ready() -> void:
	name = "SaveSystem"
	add_to_group("save")
	if not DirAccess.dir_exists_absolute(SAVE_DIR):
		DirAccess.make_abs_absolute(SAVE_DIR)

func save_game(slot: int, game_data: Dictionary) -> void:
	current_save = game_data
	current_save["timestamp"] = Time.get_datetime_string_from_system()
	
	var save_file = SAVE_DIR + "save_%d.json" % slot
	var json_string = JSON.stringify(current_save)
	
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		game_saved.emit(slot)

func load_game(slot: int) -> Dictionary:
	var save_file = SAVE_DIR + "save_%d.json" % slot
	
	if not ResourceLoader.exists(save_file):
		return {}
	
	var file = FileAccess.open(save_file, FileAccess.READ)
	if file:
		var json = JSON.new()
		current_save = json.parse(file.get_as_text())
		game_loaded.emit(slot)
		return current_save
	
	return {}

func delete_save(slot: int) -> void:
	var save_file = SAVE_DIR + "save_%d.json" % slot
	if ResourceLoader.exists(save_file):
		DirAccess.remove_absolute(save_file)
		save_deleted.emit(slot)

func get_all_saves() -> Array:
	var saves = []
	var dir = DirAccess.open(SAVE_DIR)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if file_name.starts_with("save_") and file_name.ends_with(".json"):
				saves.append(file_name)
			file_name = dir.get_next()
	
	return saves

func save_exists(slot: int) -> bool:
	return ResourceLoader.exists(SAVE_DIR + "save_%d.json" % slot)
