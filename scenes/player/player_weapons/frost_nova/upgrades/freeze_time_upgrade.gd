class_name FreezeTimeUpgrade
extends WeaponUpgrade

@export var freeze_time_increase: float = 1.0
func _apply_upgrade(weapon: PlayerWeapon):
	if (!weapon.get("freeze_time")):
		print("Weapon: " + str(weapon.display_name) + " has no attribute freeze_time. Either add this attribute to the weapon or use a different upgrade.")
	weapon.freeze_time += freeze_time_increase

func _remove_upgrade(weapon: PlayerWeapon):
	if (!weapon.get("freeze_time")):
		print("Weapon: " + str(weapon.display_name) + " has no attribute freeze_time. Either add this attribute to the weapon or use a different upgrade.")
	weapon.freeze_time -= freeze_time_increase
