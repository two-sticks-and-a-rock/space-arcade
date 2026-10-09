class_name DowntimeUpgrade
extends WeaponUpgrade

@export var downtimer_decrease: float = 2.0

func _apply_upgrade(weapon: PlayerWeapon):
    if (weapon.down_timer.wait_time - downtimer_decrease <= 0):
        print("Down timer should never go to 0 or lower. If you want to set the weapon to always up, use AlwaysOnUpgrade")
        return
    weapon.down_timer.wait_time -= downtimer_decrease

func _remove_upgrade(weapon: PlayerWeapon):
    weapon.down_timer.wait_time += downtimer_decrease
