extends RigidBody2D

signal hit

@export var speed = 400
var direction = Vector2.ZERO

func _physics_process(_delta):
	linear_velocity = direction * speed
	direction = lerp(direction, Vector2.ZERO, 0.01)

func _on_body_entered(_body):
	print("_on_body_entered")
	# disable player collision
	# hide()
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
