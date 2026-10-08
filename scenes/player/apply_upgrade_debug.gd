extends Button

@export var damage_upgrade : DamageUpgrade

# Called when the node enters the scene tree for the first time.
func _ready():
	damage_upgrade.dmg_increase = 100

func _on_apply_upgrade_debug_pressed():
	print("Apply Damage Upgrade +100")
	var orbiter_ring = get_parent().get_node("OrbiterRing") as PlayerWeapon
	orbiter_ring.upgrades.append(damage_upgrade)
	orbiter_ring.apply_upgrades()
