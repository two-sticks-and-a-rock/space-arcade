extends Node

var direction : Vector2 = Vector2.ZERO
var speed : float = 0.0

var velocity

func exp_decay(a: Vector2, b: Vector2, decay: float, delta: float):
	return b+(a-b)*exp(-decay*delta)

func reset() -> void:
	direction = Vector2.ZERO
	speed = 0.0

func get_movement() -> Vector2:
	return velocity

func _physics_process(delta):
	velocity = direction * speed * 2
	# direction = lerp(direction, Vector2.ZERO, 0.01)
	direction = exp_decay(direction, Vector2.ZERO, 0.1, delta)