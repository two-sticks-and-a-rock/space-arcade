class_name BulletSpeedUpgrade
extends WeaponUpgrade

@export var bullet_speed_increase: float = 1.5

func _apply_upgrade(weapon: PlayerWeapon):
    weapon.bullet_speed *= bullet_speed_increase

func _remove_upgrade(weapon: PlayerWeapon):
    weapon.bullet_speed /= bullet_speed_increase
