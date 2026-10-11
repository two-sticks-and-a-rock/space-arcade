extends PlayerBullet

func _on_orbiter_entered(body: Node2D):
	if body.is_in_group("enemy"):
		body.freeze()
