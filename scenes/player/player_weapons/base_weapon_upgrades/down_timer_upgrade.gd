class_name DownTimerUpgrade
extends PlayerWeaponUpgrade

@export var down_timer_decrease: float = 2

func _apply_upgrade(weapon: PlayerWeapon):
    weapon.down_timer.wait_time -= down_timer_decrease

func _remove_upgrade(weapon: PlayerWeapon):
    weapon.down_timer.wait_time += down_timer_decrease