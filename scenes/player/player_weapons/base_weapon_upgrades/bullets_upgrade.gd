class_name BulletsUpgrade
extends PlayerWeaponUpgrade

@export var bullets_increase: int = 1

func _apply_upgrade(weapon: PlayerWeapon):
    weapon.bullets += bullets_increase