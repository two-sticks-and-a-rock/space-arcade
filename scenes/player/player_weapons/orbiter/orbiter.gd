extends PlayerBullet

func _physics_process(_delta):
	position = Vector2(position).rotated(weapon.bullet_speed)
