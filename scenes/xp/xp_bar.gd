extends ProgressBar

# func _physics_process(delta):
	# position = Vector2(Mover.get_movement().x * delta, Mover.get_movement().y * delta)
func _physics_process(delta):
	position -= Mover.get_movement()*delta
	position = lerp(position, Vector2.ZERO, 0.1)