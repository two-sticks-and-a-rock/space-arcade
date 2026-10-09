class_name BulletSizeUpgrade
extends PlayerWeaponUpgrade

@export var bullet_size_increase: int = 10

func _apply_upgrade(weapon: PlayerWeapon):
    weapon.bullet_size += bullet_size_increase