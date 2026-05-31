extends Control

func _ready() -> void:
	var restart_button = $VBoxContainer/RestartButton
	restart_button.pressed.connect(_on_restart_pressed)


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")
