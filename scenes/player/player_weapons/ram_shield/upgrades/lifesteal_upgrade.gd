class_name LifestealUpgrade
extends WeaponUpgrade

@export var lifesteal_increase: int = 5

func _apply_upgrade(weapon: PlayerWeapon):
	if (!weapon.get("lifesteal")):
		print("Weapon: " + str(weapon.display_name) + " has no attribute lifesteal. Either add this attribute to the weapon or use a different upgrade.")
	weapon.lifesteal += lifesteal_increase

func _remove_upgrade(weapon: PlayerWeapon):
	if (!weapon.get("lifesteal")):
		print("Weapon: " + str(weapon.display_name) + " has no attribute lifesteal. Either add this attribute to the weapon or use a different upgrade.")
	weapon.lifesteal -= lifesteal_increase
