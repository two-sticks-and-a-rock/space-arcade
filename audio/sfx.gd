extends Node

# Gameplay SFX that play once
const SOUNDS := {
	"enemy_death": preload("res://audio/SFX/Gameplay SFX/enemy_death.wav"),
	"thruster_small": preload("res://audio/SFX/Gameplay SFX/thruster_small.wav"),
	"XP_pickup": preload("res://audio/SFX/Gameplay SFX/Final_XP.wav"), #I changed this because the XP sfx sounded too much like the UI sfx, so this is more like a coin. Swap it with XP_pickup or new_XP.
	"orbiter_activate": preload("res://audio/SFX/Gameplay SFX/orbiter_sfx02.wav"),
	"cryo_activate": preload("res://audio/SFX/Gameplay SFX/Frost_Nova_Icy02.wav"),
	"shield_up": preload("res://audio/SFX/Gameplay SFX/doorOpen_002.ogg"),
	"shield_down": preload("res://audio/SFX/Gameplay SFX/doorClose_002.ogg"),
	"heal_repair": preload ("res://audio/SFX/Gameplay SFX/powerUp.wav"),
	"hit_marker": preload("res://audio/SFX/Gameplay SFX/hit_marker02.wav"),
	"player_damaged": preload("res://audio/SFX/Gameplay SFX/player_dmg01.wav"),
	"frozen_enemy": preload("res://audio/SFX/Gameplay SFX/Enemy_Freeze.wav"),
	"missile_launcher": preload("res://audio/SFX/Gameplay SFX/missile_launcher.wav"),
	"missile_reload": preload("res://audio/SFX/Gameplay SFX/missile_reload.wav"),
	"UI_positive": preload("res://audio/SFX/UI SFX/UI_positive.wav"),
	"UI_negative": preload("res://audio/SFX/UI SFX/UI_negative.wav")
	
}
# Volume of each sound
const VOLUMES := {
	"enemy_death": -5.5,
	"thruster_small": -9.5,
	"XP_pickup": -20.5,
	"orbiter_activate": 1.25,
	"shield_up": -7.0,
	"shield_down": -7.0,
	"heal_repair": -6.5,
	"cryo_activate": -8.0,
	"player_damaged": -6.5,
	"frozen_enemy": -18.0,
	"missile_launcher": -3.0,
	"missile_reload": -2.0,
	"UI_positive": -5.5,
	"UI_negative": -5.5,
}

# the constant sound of the player's ship engines
const engine_idle := preload("res://audio/SFX/Gameplay SFX/engine_idle.wav")
const engine_idle_volume := -5.0

const cooldown_sound := ["hit_marker", "player_damaged", "XP_pickup", "enemy_death"]
const random_pitch_sounds := ["enemy_death", "hit_marker", "player_damaged"]

var _players := {}
var _last_played := {}
var _idle := AudioStreamPlayer2D.new()

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS #hoping this fixes sound being cut during pause menus
	for sound_name in SOUNDS:
		var player := AudioStreamPlayer.new()
		var stream: AudioStream = SOUNDS[sound_name]
		if sound_name in random_pitch_sounds:
			var randomizer := AudioStreamRandomizer.new()
			randomizer.add_stream(0, stream)
			randomizer.playback_mode = AudioStreamRandomizer.PLAYBACK_RANDOM
			randomizer.random_pitch = 1.1
			stream = randomizer
		player.stream = stream
		player.volume_db = VOLUMES.get(sound_name, 0.0)
		player.max_polyphony = 5  # lets several play at once (lots of enemies dying)
		player.bus = "SFX"
		add_child(player)
		_players[sound_name] = player
	_idle.stream = engine_idle
	_idle.volume_db = engine_idle_volume
	add_child(_idle)
	_idle.play()

func play(sound_name: String):
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
	_players["thruster_small"].pitch_scale = randf_range(0.8, 1.1)
	play("thruster_small")
