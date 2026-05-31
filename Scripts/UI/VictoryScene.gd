extends Control

func _ready() -> void:
	var exit_button = $VBoxContainer/ExitButton
	exit_button.pressed.connect(_on_exit_pressed)


func _on_exit_pressed() -> void:
	get_tree().quit()
