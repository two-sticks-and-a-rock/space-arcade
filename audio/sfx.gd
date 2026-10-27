extends Node

# Short sounds that play once
const SOUNDS := {
	"enemy_death": preload("res://audio/SFX/enemy_death.wav"),
	"thruster_small": preload("res://audio/SFX/thruster_small.wav"),
	"XP_pickup": preload("res://audio/SFX/XP_pickup.wav"),
}

# Volume of each sound
const VOLUMES := {
	"enemy_death": -6.0,
	"thruster_small": -8.0,
	"XP_pickup": -6.0,
}

# the constant sound of the player's ship engines
const engine_idle := preload("res://audio/SFX/engine_idle.wav")
const engine_idle_volume := -8.0

var _players := {}
var _idle := AudioStreamPlayer2D.new()

func _ready():
	for sound_name in SOUNDS:
		var player := AudioStreamPlayer.new()
		player.stream = SOUNDS[sound_name]
		player.volume_db = VOLUMES.get(sound_name, 0.0)
		player.max_polyphony = 6  # lets several play at once (lots of enemies dying)
		player.bus = "SFX"
		add_child(player)
		_players[sound_name] = player
	_idle.stream = engine_idle
	_idle.volume_db = engine_idle_volume
	add_child(_idle)
	_idle.play()

func play(sound_name: String):
	if _players.has(sound_name):
		_players[sound_name].play()
	else:
		push_warning("Sfx: no sound called " + sound_name)

# Called by the slingshot script when the player lets go of the mouse
func thrust_start():
	# need to work on testing different sounds for different player speed 
	if Mover.speed < 10.0:
		return
	play("thruster_small")
