extends Node

var _player := AudioStreamPlayer.new()

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	_player.stream = preload("res://audio/Music/Stars by the Willoughby_v2.wav")
	_player.bus = "Music"
	_player.volume_db = 0.0
	add_child(_player)
	_player.play()
