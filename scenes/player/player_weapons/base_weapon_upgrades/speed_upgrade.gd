class_name SpeedUpgrade
extends PlayerWeaponUpgrade

@export var bullet_speed_increase: float = 1.5

func _apply_upgrade(weapon: PlayerWeapon):
    weapon.bullet_speed *= bullet_speed_increase