extends StaticBody2D

signal hit

func _on_body_entered(_body):
	# disable player collision
	# hide()
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
