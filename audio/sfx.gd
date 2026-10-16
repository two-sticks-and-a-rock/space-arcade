extends Node

# Short sounds that play once. Add new ones to this list.
const SOUNDS := {
	"enemy_death": preload("res://audio/SFX/enemy_death.wav"),
}

# The three thruster sounds
const THRUST_IGNITION := preload("res://audio/SFX/thruster_ignition.wav")
const THRUST_LOOP := preload("res://audio/SFX/thruster_loop.wav")
const THRUST_RELEASE := preload("res://audio/SFX/thruster_release.wav")

var _players := {}
var _thrust := AudioStreamPlayer.new()
var _thrusting := false

func _ready():
	# Make one player for each short sound
	for sound_name in SOUNDS:
		var player := AudioStreamPlayer.new()
		player.stream = SOUNDS[sound_name]
		player.max_polyphony = 6  # lets several play at once (lots of enemies dying)
		add_child(player)
		_players[sound_name] = player
	# Make the thruster player
	add_child(_thrust)
	_thrust.finished.connect(_on_thrust_finished)

func play(sound_name: String):
	if _players.has(sound_name):
		_players[sound_name].play()
	else:
		push_warning("Sfx: no sound called " + sound_name)

func thrust_start():
	if _thrusting:
		return
	_thrusting = true
	_thrust.stream = THRUST_IGNITION
	_thrust.play()

func thrust_stop():
	if not _thrusting:
		return
	_thrusting = false
	_thrust.stream = THRUST_RELEASE
	_thrust.play()

func _on_thrust_finished():
	# When the ignition ends, switch to the loop if the player is still thrusting
	if _thrusting and _thrust.stream == THRUST_IGNITION:
		_thrust.stream = THRUST_LOOP
		_thrust.play()
