extends CanvasLayer

@onready var upgrade_panel_scene : PackedScene = load("res://scenes/upgrade_menu/upgrade_panel.tscn")
@onready var h_container : HBoxContainer = $PanelContainer/HBoxContainer

var hit_max_level : bool = false

func _ready():
	EventBus.level_up.connect(_on_player_level_up)
	EventBus.finish_level_up.connect(_on_player_finish_level_up)
	visible = false
	
func clear_upgrade_panels():
	for child in h_container.get_children():
		if child is MarginContainer:
			child.queue_free()
	
func populate_upgrade_panels():
	# get the players list of weapons
	var player_weapons = get_tree().root.get_node("Main/player").get_children().filter(
		func(child):
			return child is PlayerWeapon
	)

	# get all potential upgrades for those weapons
	var possible_upgrade_sets = []
	var all_possible_upgrades_length = 0
	var upgrade_set_name_to_weapon: Dictionary[String, PlayerWeapon] = {}
	for weapon in player_weapons:
		var weapon_upgrade_sets = weapon.possible_upgrade_sets.filter(
			func(upgrade_set):
				return !upgrade_set.applied
		)
		
		if (weapon_upgrade_sets.size() == 0):
			continue
	
		upgrade_set_name_to_weapon[weapon_upgrade_sets[0].resource_name] = weapon

		# Just get the first non-applied weapon upgrade set per weapon
		possible_upgrade_sets.append(weapon_upgrade_sets[0])
		all_possible_upgrades_length += weapon_upgrade_sets.size()

	# TODO: handle non-weapon upgrades
	
	# TODO: once this is big enough, get 3 random upgrades

	var num_displayed = 0
	for possible_upgrade_set in possible_upgrade_sets:
		if (num_displayed >= 3):
			break
		num_displayed += 1

		# Instantiate an upgrade panel and fill in fields
		var upgrade_panel : MarginContainer = upgrade_panel_scene.instantiate()
		
		upgrade_panel.upgrade_name = possible_upgrade_set.resource_name

		# TODO: placeholder images
		# upgrade_panel.img_filepath = 
		upgrade_panel.mechanics = ([] as Array[String])
		for component_upgrade in possible_upgrade_set.upgrades:
			upgrade_panel.mechanics.append(component_upgrade.resource_name)
		
		upgrade_panel.on_panel_pressed = func():
			var weapon = upgrade_set_name_to_weapon[possible_upgrade_set.resource_name]
			weapon.upgrades += possible_upgrade_set.upgrades
			possible_upgrade_set.applied = true

			weapon._reset()
			if (all_possible_upgrades_length <= 1):
				hit_max_level = true
			EventBus.finish_level_up.emit()
		
		h_container.add_child(upgrade_panel)


func _on_player_level_up():
	if (hit_max_level):
		return

	populate_upgrade_panels.call_deferred()
	visible = true
	get_tree().paused = true

func _on_player_finish_level_up():
	clear_upgrade_panels.call_deferred()
	visible = false
	get_tree().paused = false
