extends PlayerBullet

func _on_orbiter_entered(body: Node2D):
	if ("take_damage" in body):
		body.freeze()
