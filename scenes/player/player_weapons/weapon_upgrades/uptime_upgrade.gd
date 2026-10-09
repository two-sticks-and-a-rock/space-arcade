class_name UptimeUpgrade
extends WeaponUpgrade

@export var uptimer_increase: float = 2.0

func _apply_upgrade(weapon: PlayerWeapon):
    weapon.up_timer.wait_time += uptimer_increase

func _remove_upgrade(weapon: PlayerWeapon):
    weapon.up_timer.wait_time -= uptimer_increase
