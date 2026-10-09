extends CanvasLayer

@onready var upgrade_panel_scene : PackedScene = load("res://scenes/upgrade_menu/upgrade_panel.tscn")
@onready var h_container : HBoxContainer = $PanelContainer/HBoxContainer

func _ready():
	EventBus.level_up.connect(_on_player_level_up)
	visible = false
		

func populate_upgrade_panels():
	# get the players list of weapons
	var player_weapons = get_tree().root.get_node("Main/player").get_children().filter(
		func(child):
			return child is PlayerWeapon
	)

	# get all potential upgrades for those weapons
	var potential_upgrade_sets = []
	for weapon in player_weapons:
		var weapon_upgrade_sets = weapon._get_upgrade_sets().filter(
			func(upgrade_set):
				return !upgrade_set.applied
		)
		if (weapon_upgrade_sets.size() == 0):
			continue
	
		potential_upgrade_sets.append(weapon_upgrade_sets[0])

	# TODO: handle non-weapon upgrades
	
	var num_displayed = 0
	for potential_upgrade_set in potential_upgrade_sets:
		if (num_displayed == 3):
			break

		var upgrade_panel = upgrade_panel_scene.instantiate()
		
		upgrade_panel.upgrade_name = potential_upgrade_set.name
		upgrade_panel.mechanics = ([] as Array[String])
		for component_upgrade in potential_upgrade_set.component_upgrades:
			upgrade_panel.mechanics.append(component_upgrade.label)

		h_container.add_child(upgrade_panel)
		potential_upgrade_set.applied = true

		num_displayed += 1

func _on_player_level_up():
	populate_upgrade_panels()
	visible = true
	get_tree().paused = true
