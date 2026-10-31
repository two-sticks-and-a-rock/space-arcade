extends Node

var _player := AudioStreamPlayer.new()

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	_player.stream = preload("res://audio/Music/IQMJTDT.wav")
	_player.bus = "Music"
	_player.volume_db = -6.0
	add_child(_player)
	_player.play()
