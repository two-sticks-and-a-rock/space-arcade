class_name NumBulletsUpgrade
extends WeaponUpgrade

@export var num_bullets_increase: int = 1

func _apply_upgrade(weapon: PlayerWeapon):
    weapon.num_bullets += num_bullets_increase

func _remove_upgrade(weapon: PlayerWeapon):
    weapon.num_bullets -= num_bullets_increase
