class_name HealUpgrade
extends ConsumableUpgrade

@export var heal_percent : float = 0.1
@export var use_percent : bool = true

@export var heal_value : int = 50

func _apply_upgrade(player: Player):
	if use_percent:
		player.heal_damage(ceil(player.max_hp * heal_percent))
	else:
		player.heal_damage(heal_value)

func _remove_upgrade(_player: Player):
	print("Consumable Upgrade. This upgrade is not removeable")
	pass
