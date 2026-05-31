extends Node

const AUDIO_PATHS = {
	"jumpscare": "res://Audio/SFX/jumpscare.ogg",
	"alarm": "res://Audio/SFX/alarm.ogg",
	"footstep_1": "res://Audio/SFX/footstep_1.ogg",
	"footstep_2": "res://Audio/SFX/footstep_2.ogg",
	"interaction": "res://Audio/SFX/interaction.ogg",
	"pickup": "res://Audio/SFX/pickup.ogg",
	"serve": "res://Audio/SFX/serve.ogg",
	"fail": "res://Audio/SFX/fail.ogg",
	"camera_detect": "res://Audio/SFX/camera_detect.ogg",
	"smiling_man": "res://Audio/SFX/smiling_man_laugh.ogg",
	"inspector": "res://Audio/SFX/inspector_knock.ogg",
	"victory": "res://Audio/SFX/victory.ogg",
	"gameover": "res://Audio/SFX/gameover.ogg",
	"background_music": "res://Audio/Music/night_shift.ogg",
	"ambient_restaurant": "res://Audio/Ambient/restaurant_hum.ogg"
}

var audio_manager: Node

func _ready() -> void:
	audio_manager = get_tree().get_first_child_in_group("audio")


func play_sound(sound_name: String, volume: float = 1.0) -> void:
	if sound_name in AUDIO_PATHS and audio_manager:
		audio_manager.play_sfx(sound_name, AUDIO_PATHS[sound_name], volume)


func play_footstep() -> void:
	var step = "footstep_1" if randf() > 0.5 else "footstep_2"
	play_sound(step, 0.6)


func play_background_music() -> void:
	if audio_manager:
		audio_manager.play_music(AUDIO_PATHS["background_music"])


func play_ambient() -> void:
	if audio_manager:
		audio_manager.play_ambient(AUDIO_PATHS["ambient_restaurant"], 0.3)
