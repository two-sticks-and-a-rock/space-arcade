extends Button

@export var damage_upgrade : DamageUpgrade
@export var bullets_upgrade : BulletsUpgrade
@export var speed_upgrade : SpeedUpgrade
@export var up_timer_upgrade : UpTimerUpgrade
@export var down_timer_upgrade : DownTimerUpgrade

# Called when the node enters the scene tree for the first time.
func _ready():
	damage_upgrade.dmg_increase = 100
	bullets_upgrade.bullets_increase = 3
	speed_upgrade.bullet_speed_increase = 4
	up_timer_upgrade.up_timer_increase = 4
	down_timer_upgrade.down_timer_decrease = 4

func _on_apply_upgrade_debug_pressed():
	var orbiter_ring = get_parent().get_parent().get_node("OrbiterRing") as PlayerWeapon

	# orbiter_ring.upgrades.append(damage_upgrade)
	# orbiter_ring.upgrades.append(bullets_upgrade)
	# orbiter_ring.upgrades.append(speed_upgrade)
	# orbiter_ring.upgrades.append(up_timer_upgrade)
	# orbiter_ring.upgrades.append(down_timer_upgrade)
	orbiter_ring._reset()
