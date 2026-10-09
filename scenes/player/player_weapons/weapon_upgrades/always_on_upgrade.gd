class_name AlwaysOnUpgrade
extends WeaponUpgrade

func _apply_upgrade(weapon: PlayerWeapon):
    weapon._remove_timers()

func _remove_upgrade(weapon: PlayerWeapon):
    weapon._add_timers()
