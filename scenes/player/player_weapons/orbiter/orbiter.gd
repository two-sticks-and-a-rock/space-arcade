extends PlayerBullet

# TODO: this is hacky. It's here because the asteroid png is slightly bigger than we want
var scale_for_sprite = 0.5

func _physics_process(_delta):
	position = Vector2(position).rotated(weapon.bullet_speed)
