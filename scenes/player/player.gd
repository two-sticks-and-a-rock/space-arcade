extends StaticBody2D

signal game_over

@export var orbiter_ring_scene : PackedScene

@onready var hp_bar : ProgressBar = $hp
@onready var xp_bar : ProgressBar = $XpCanvas/XpBar
@onready var magnet_collider : CollisionShape2D = $XpMagnet/CollisionShape2D

var max_hp : int = 500
var curr_hp : int = max_hp
var magnet_radius : int = 150

func _ready():
	hp_bar.max_value = max_hp
	hp_bar.value = max_hp

	var orbiter_ring = orbiter_ring_scene.instantiate() as Node2D
	add_child(orbiter_ring)
	(magnet_collider.shape as CircleShape2D).radius = magnet_radius

func take_damage(dmg: int):
	curr_hp -= dmg

func gain_xp(xp: int):
	xp_bar.gain_xp(xp)

func handle_game_over():
	get_tree().paused = true
	emit_signal("game_over")

func _physics_process(_delta):
	hp_bar.value = curr_hp
	if (curr_hp <= 0):
		handle_game_over()

	constant_linear_velocity = Mover.get_movement()
