extends Control

var audio_manager: Node

func _ready() -> void:
	audio_manager = get_tree().get_first_child_in_group("audio")
	
	var master_slider = $VBoxContainer/MasterVolumeContainer/MasterVolumeSlider
	var music_slider = $VBoxContainer/MusicVolumeContainer/MusicVolumeSlider
	var sfx_slider = $VBoxContainer/SFXVolumeContainer/SFXVolumeSlider
	
	master_slider.value_changed.connect(_on_master_volume_changed)
	music_slider.value_changed.connect(_on_music_volume_changed)
	sfx_slider.value_changed.connect(_on_sfx_volume_changed)
	$VBoxContainer/BackButton.pressed.connect(_on_back_pressed)


func _on_master_volume_changed(value: float) -> void:
	if audio_manager:
		audio_manager.set_master_volume(value)


func _on_music_volume_changed(value: float) -> void:
	if audio_manager:
		audio_manager.set_music_volume(value)


func _on_sfx_volume_changed(value: float) -> void:
	if audio_manager:
		audio_manager.set_sfx_volume(value)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/MainMenuScene.tscn")
