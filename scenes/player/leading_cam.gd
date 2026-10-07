extends Node2D

func _physics_process(_delta):
	position = Mover.get_movement() * 0.05 # run some amount ahead of the player
	position = lerp(position, Vector2.ZERO, 0.1)