extends PlayerBullet

var freeze_time : float
func _on_orbiter_entered(body: Node2D):
	if body.is_in_group("enemy") && body.has_method("freeze"):
		body.freeze(freeze_time)
