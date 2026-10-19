extends Node

# Short sounds that play once
const SOUNDS := {
	"enemy_death": preload("res://audio/SFX/laserRetro_001.ogg"),
	"thruster_small": preload("res://audio/SFX/thruster_small.wav"),
	"xp_pickup": preload("res://audio/SFX/XP_pickup.wav"),
}

# Volume of each sound
const VOLUMES := {
	"enemy_death": -6.0,
	"thruster_small": -8.0,
	"xp_pickup": -16.0,
}

const PITCH_VARIATION := {
	"enemy_death": 1.2,
}

# the constant sound of the player's ship engines
const engine_idle := preload("res://audio/SFX/engine_idle.wav")
const engine_idle_volume := -8.0

var _players := {}
var _idle := AudioStreamPlayer2D.new()

func _ready():
	for sound_name in SOUNDS:
		var player := AudioStreamPlayer.new()
		var randomizer := AudioStreamRandomizer.new()
		randomizer.add_stream(-1, SOUNDS[sound_name])
		randomizer.random_pitch = PITCH_VARIATION.get(sound_name, 1.0)
		player.stream = randomizer
		player.volume_db = VOLUMES.get(sound_name, 0.0)
		player.max_polyphony = 6  # lets several play at once (lots of enemies dying)
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
	# Don't play for a click with no drag
	if Mover.speed < 10.0:
		return
	play("thruster_small")
