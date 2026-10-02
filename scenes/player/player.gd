extends StaticBody2D

signal game_over

@export var orbiter_ring_scene : PackedScene

@onready var hp_bar : ProgressBar = $hp
@onready var xp_bar : ProgressBar = $XpCanvas/XpBar

var max_hp: int = 500
var curr_hp: int = max_hp

var curr_xp: int = 0
var xp_threshold : int = 100

func _ready():
	hp_bar.max_value = max_hp
	hp_bar.value = max_hp

	xp_bar.max_value = xp_threshold
	xp_bar.value = 0

	var orbiter_ring = orbiter_ring_scene.instantiate() as Node2D
	add_child(orbiter_ring)

func take_damage(dmg: int):
	curr_hp -= dmg

func handle_game_over():
	get_tree().paused = true
	emit_signal("game_over")

func handle_level_up():
	curr_xp -= max(xp_threshold, 0)
	xp_threshold = xp_threshold * 2

func gain_xp(xp: int):
	curr_xp += xp
	if (curr_xp >= xp_threshold):
		handle_level_up.call_deferred()

func _physics_process(_delta):
	hp_bar.value = curr_hp

	xp_bar.max_value = xp_threshold
	xp_bar.value = curr_xp

	if (curr_hp <= 0):
		handle_game_over()

	constant_linear_velocity = Mover.get_movement()
