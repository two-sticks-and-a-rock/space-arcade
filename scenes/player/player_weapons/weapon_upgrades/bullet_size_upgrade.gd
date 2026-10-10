class_name BulletSizeUpgrade
extends WeaponUpgrade

@export var bullet_size_increase: float = 1.0

func _apply_upgrade(weapon: PlayerWeapon):
    weapon.bullet_size *= bullet_size_increase

func _remove_upgrade(weapon: PlayerWeapon):
    weapon.bullet_size /= bullet_size_increase
