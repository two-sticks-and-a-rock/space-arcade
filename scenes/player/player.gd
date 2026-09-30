extends StaticBody2D

var max_hp: int = 100
var curr_hp: int = max_hp

func take_damage(dmg: int):
	curr_hp -= dmg

func _physics_process(_delta):
	if (curr_hp <= 0):
		# TODO game over
		get_tree().paused = true
	constant_linear_velocity = Mover.get_movement()
