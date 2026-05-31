extends Node

var master_volume = 1.0
var music_volume = 0.8
var sfx_volume = 0.9

var background_music: AudioStreamPlayer
var sfx_players: Dictionary = {}
var ambient_sound: AudioStreamPlayer

func _ready() -> void:
	name = "AudioManager"
	add_to_group("audio")
	# Create background music player
	background_music = AudioStreamPlayer.new()
	background_music.bus = "Music"
	add_child(background_music)
	
	# Create ambient sound player
	ambient_sound = AudioStreamPlayer.new()
	ambient_sound.bus = "Ambient"
	add_child(ambient_sound)


func play_music(music_path: String, loop: bool = true) -> void:
	var audio_file = load(music_path)
	if audio_file:
		background_music.stream = audio_file
		if loop:
			background_music.bus = "Music"
		background_music.play()
		background_music.volume_db = linear2db(music_volume * master_volume)


func stop_music() -> void:
	background_music.stop()


func play_sfx(sfx_name: String, sfx_path: String, volume: float = 1.0) -> AudioStreamPlayer:
	var audio_file = load(sfx_path)
	if not audio_file:
		return null
	
	var player = AudioStreamPlayer.new()
	player.stream = audio_file
	player.bus = "SFX"
	player.volume_db = linear2db(volume * sfx_volume * master_volume)
	add_child(player)
	sfx_players[sfx_name] = player
	player.finished.connect(func(): player.queue_free(); sfx_players.erase(sfx_name))
	player.play()
	return player


func play_ambient(ambient_path: String, volume: float = 0.5) -> void:
	var audio_file = load(ambient_path)
	if audio_file:
		ambient_sound.stream = audio_file
		ambient_sound.volume_db = linear2db(volume * master_volume)
		ambient_sound.play()


func stop_ambient() -> void:
	ambient_sound.stop()


func set_master_volume(volume: float) -> void:
	master_volume = clamp(volume, 0.0, 1.0)
	if background_music:
		background_music.volume_db = linear2db(music_volume * master_volume)
	if ambient_sound:
		ambient_sound.volume_db = linear2db(music_volume * master_volume)


func set_music_volume(volume: float) -> void:
	music_volume = clamp(volume, 0.0, 1.0)


func set_sfx_volume(volume: float) -> void:
	sfx_volume = clamp(volume, 0.0, 1.0)
