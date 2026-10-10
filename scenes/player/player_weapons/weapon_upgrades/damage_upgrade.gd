class_name DamageUpgrade
extends WeaponUpgrade

@export var damage_increase: int = 25

func _apply_upgrade(weapon: PlayerWeapon):
    weapon.dmg += damage_increase

func _remove_upgrade(weapon: PlayerWeapon):
    weapon.dmg -= damage_increase
