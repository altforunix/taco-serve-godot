extends Node3D

class_name InteractiveEntity

var is_interactive = true
var interaction_prompt = "Press E to interact"
var interaction_range = 3.0

signal interaction_triggered(entity: Node3D)

func _ready() -> void:
	pass

func interact(player: Node3D) -> void:
	if is_interactive:
		interaction_triggered.emit(self)

func set_interactive(value: bool) -> void:
	is_interactive = value

func get_interaction_prompt() -> String:
	return interaction_prompt
