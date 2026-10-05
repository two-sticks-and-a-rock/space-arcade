extends Node

var direction : Vector2 = Vector2.ZERO
var speed : float = 0.0

var velocity

var slingshot_length_clamp = 500
var speed_mult = 3

func reset() -> void:
	direction = Vector2.ZERO
	speed = 0.0

func get_movement() -> Vector2:
	return velocity

func _physics_process(_delta):
	velocity = direction * speed * speed_mult
	direction = lerp(direction, Vector2.ZERO, 0.01)
