extends Button

@export var damage_upgrade : DamageUpgrade
@export var bullets_upgrade : BulletsUpgrade
@export var speed_upgrade : SpeedUpgrade
@export var up_timer_upgrade : UpTimerUpgrade
@export var down_timer_upgrade : DownTimerUpgrade

func _on_apply_upgrade_debug_pressed():
	var orbiter_ring = get_parent().get_parent().get_node("OrbiterRing") as PlayerWeapon

	# orbiter_ring.upgrades.append(damage_upgrade)
	orbiter_ring.upgrades.append(bullets_upgrade)
	# orbiter_ring.upgrades.append(speed_upgrade)
	# orbiter_ring.upgrades.append(up_timer_upgrade)
	# orbiter_ring.upgrades.append(down_timer_upgrade)
	orbiter_ring._reload()
