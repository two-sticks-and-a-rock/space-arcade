class_name BulletSizeUpgrade
extends PlayerWeaponUpgrade

@export var bullet_size_increase: float = 2.0

func _apply_upgrade(weapon: PlayerWeapon):
    weapon.bullet_size *= bullet_size_increase

func _remove_upgrade(weapon: PlayerWeapon):
    weapon.bullet_size /= bullet_size_increase