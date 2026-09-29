extends Node2D

var direction : Vector2 = Vector2.ZERO
var speed : float = 0.0

func _process(_delta):
	var old_pos = global_position
	var new_pos = old_pos + (speed * direction) * -1
	global_position = new_pos

	direction = lerp(direction, Vector2.ZERO, 0.1)
