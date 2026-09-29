extends Node2D

var direction : Vector2 = Vector2.ZERO
var speed : float = 0.0

func _process(_delta):
	for child in get_children():
		if "global_position" in child:
			var old_pos = child.global_position
			var new_pos = old_pos + (speed * direction) * -1
			child.global_position = new_pos
	direction = lerp(direction, Vector2.ZERO, 0.1)
