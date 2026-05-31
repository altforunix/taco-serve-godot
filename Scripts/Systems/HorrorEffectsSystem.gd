extends Node

class_name HorrorEffectsSystem

var camera: Camera3D
var original_fov: float = 75.0
var sanity: float = 100.0
var sanity_drain_rate: float = 0.5

signal sanity_changed(new_sanity: float)
signal sanity_critical
signal visual_distortion_triggered

func _ready() -> void:
	name = "HorrorEffectsSystem"
	add_to_group("horror_effects")
	if get_tree().root.has_node("MainScene/Player/Camera3D"):
		camera = get_tree().root.get_node("MainScene/Player/Camera3D")
		original_fov = camera.fov

func _process(delta: float) -> void:
	if sanity > 0:
		sanity -= sanity_drain_rate * delta
		if sanity < 0:
			sanity = 0
			sanity_critical.emit()
		sanity_changed.emit(sanity)

func drain_sanity(amount: float) -> void:
	sanity -= amount
	if sanity <= 0:
		sanity_critical.emit()

func restore_sanity(amount: float) -> void:
	sanity = clamp(sanity + amount, 0.0, 100.0)

func apply_visual_distortion() -> void:
	if camera:
		var distortion_amount = (100.0 - sanity) / 100.0
		camera.fov = original_fov + (distortion_amount * 20.0)
		visual_distortion_triggered.emit()

func get_sanity_percentage() -> float:
	return sanity / 100.0

func trigger_jumpscare() -> void:
	drain_sanity(20.0)
	apply_visual_distortion()

func trigger_entity_encounter() -> void:
	drain_sanity(10.0)

apply_visual_distortion()
