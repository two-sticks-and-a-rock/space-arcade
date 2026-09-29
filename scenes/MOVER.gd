extends Node

var direction : Vector2 = Vector2.ZERO
var speed : float = 0.0

var velocity

func get_movement() -> Vector2:
	return velocity

func _physics_process(_delta):
	velocity = direction * speed
	direction = lerp(direction, Vector2.ZERO, 0.01)