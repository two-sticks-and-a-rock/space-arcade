class_name BulletSizeUpgrade
extends WeaponUpgrade

@export var bullet_scale: float = 1.0
var old_size : float = 1.0

func _apply_upgrade(weapon: PlayerWeapon):
	old_size = weapon.bullet_size
	weapon.bullet_size = bullet_scale

func _remove_upgrade(weapon: PlayerWeapon):
	weapon.bullet_size = old_size
