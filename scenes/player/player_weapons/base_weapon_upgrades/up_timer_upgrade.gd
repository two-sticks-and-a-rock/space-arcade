class_name UpTimerUpgrade
extends PlayerWeaponUpgrade

@export var up_timer_increase: float = 2

func _apply_upgrade(weapon: PlayerWeapon):
    weapon.up_timer.wait_time += up_timer_increase