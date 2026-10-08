class_name DamageUpgrade
extends PlayerWeaponUpgrade

@export var dmg_increase: int = 50

func _apply_upgrade(weapon: PlayerWeapon):
    weapon.dmg += dmg_increase