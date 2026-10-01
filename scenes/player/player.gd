extends StaticBody2D

signal game_over

@onready var hp_bar : ProgressBar = $hp

var max_hp: int = 100
var curr_hp: int = max_hp

func _ready():
	hp_bar.max_value = max_hp
	hp_bar.value = max_hp

func take_damage(dmg: int):
	curr_hp -= dmg

func _physics_process(_delta):
	hp_bar.value = curr_hp
	if (curr_hp <= 0):
		get_tree().paused = true
		emit_signal("game_over")

	constant_linear_velocity = Mover.get_movement()
