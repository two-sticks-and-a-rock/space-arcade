extends Node

# Gameplay SFX that play once
const SOUNDS := {
	"enemy_death": preload("res://audio/SFX/enemy_death.wav"),
	"thruster_small": preload("res://audio/SFX/thruster_small.wav"),
	"XP_pickup": preload("res://audio/SFX/new_XP.wav"),
	"orbiter_activate": preload("res://audio/SFX/orbiter_sfx02.wav"),
	"cryo_activate": preload("res://audio/SFX/cryo_sfx01.wav"),
	"shield_up": preload("res://audio/SFX/doorOpen_002.ogg"),
	"shield_down": preload("res://audio/SFX/doorClose_002.ogg"),
	"heal_repair": preload ("res://audio/SFX/powerUp.wav"),
	"hit_marker": preload("res://audio/SFX/hit_marker.wav"),
}

#UI SFX here
const UI_SOUNDS := [
	
]

# Volume of each sound
const VOLUMES := {
	"enemy_death": -10.0,
	"thruster_small": -10.0,
	"XP_pickup": -8.0,
	"orbiter_activate": 2.0,
	"shield_up": -2.0,
	"shield_down": -2.0,
	"heal_repair": 2.0,
}

# the constant sound of the player's ship engines
const engine_idle := preload("res://audio/SFX/engine_idle.wav")
const engine_idle_volume := -6.0

const cooldown_sound := ["hit_marker"]

var _players := {}
var _last_played := {}
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
	if get_tree().paused and sound_name not in UI_SOUNDS:
		return
	if not _players.has(sound_name):
		push_warning("Sfx: no sound called" + sound_name)
		return
	if sound_name in cooldown_sound:
		var now := Time.get_ticks_msec()
		if now - _last_played.get(sound_name, -1000) < 40:
			return
		_last_played[sound_name] = now
	_players [sound_name].play()

# Called by the slingshot script when the player lets go of the mouse
func thrust_start():
	# need to work on testing different sounds for different player speed 
	if Mover.speed < 10.0:
		return
	play("thruster_small")
