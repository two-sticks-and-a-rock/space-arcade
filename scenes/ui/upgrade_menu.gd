extends CanvasLayer

@onready var upgrade_panel_scene : PackedScene = load("res://scenes/ui/upgrade_panel.tscn")
@onready var h_container : HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer
var hit_max_level = false

var starting_weapon_scene : PackedScene = load("res://scenes/player/player_weapons/ram_shield/ram_shield.tscn")

@onready var misc_upgrades_node : Node2D = $ConsumableUpgrades

class UpgradeSetMetadata:
	var possible_upgrade_sets: Array[WeaponUpgradeSet] = []
	var all_possible_upgrades_length: int = 0
	var upgrade_set_name_to_weapon_map: Dictionary[String, PlayerWeapon] = {}

func get_unobtained_weapons(player_weapons: Array) -> Array[PlayerWeapon]:
	var prefix : String = "res://scenes/player/player_weapons/"
	var dirs : PackedStringArray = ResourceLoader.list_directory(prefix)

	var all_weapon_dirs : Array[String] = []
	for dir in dirs:
		if !dir.contains("/") || dir.contains("weapon_upgrades"):
			continue
		all_weapon_dirs.append(prefix + dir)

	var all_weapons : Array[PlayerWeapon] = []
	for weapon_dir in all_weapon_dirs:
		var weapon_files = ResourceLoader.list_directory(weapon_dir)
		for weapon_file in weapon_files:
			if !weapon_file.contains(".tscn"):
				continue

			var weapon_scene : Node2D = (load(weapon_dir + weapon_file) as PackedScene).instantiate()
			var weapon_node : PlayerWeapon = weapon_scene as PlayerWeapon
			if weapon_node == null:
				weapon_scene.free()
				continue
			
			all_weapons.append(weapon_node)


	if player_weapons.size() == 0:
		return all_weapons

	var new_weapons : Array[PlayerWeapon] = []

	for weapon in all_weapons:
		var player_has_weapon = false
		for player_weapon in player_weapons:
			if weapon.get_script() == player_weapon.get_script():
				player_has_weapon = true
		if !player_has_weapon:
			new_weapons.append(weapon)
	return new_weapons

# TODO: this gets mad for some reason when I try to specify "player_weapons: Array[PlayerWeapon]"
# but the debugger says its the OrbiterRing is a PlayerWeapon so this might just be buggy
func get_possible_upgrade_sets(player_weapons: Array) -> UpgradeSetMetadata:
	var upgrade_set_metadata = UpgradeSetMetadata.new()

	for weapon in player_weapons:
		var weapon_upgrade_sets = weapon.possible_upgrade_sets.filter(
			func(upgrade_set):
				return !upgrade_set.applied
		)
		
		if (weapon_upgrade_sets.size() == 0):
			continue

		upgrade_set_metadata.upgrade_set_name_to_weapon_map[weapon_upgrade_sets[0].resource_name] = weapon

		# Just get the first non-applied weapon upgrade set per weapon
		upgrade_set_metadata.possible_upgrade_sets.append(weapon_upgrade_sets[0])
		upgrade_set_metadata.all_possible_upgrades_length += weapon_upgrade_sets.size()

	return upgrade_set_metadata

func get_misc_upgrades():
	return misc_upgrades_node.upgrades

func choose_at_most_n(to_choose_from: Array, n: int):
	var total = to_choose_from.size()
	if (n > total):
		return to_choose_from

	var num_to_choose = min(total, n)
	
	var sliced = to_choose_from
	sliced.shuffle()
	return sliced.slice(0, num_to_choose)

func populate_upgrade_panels():
	var player = get_tree().root.get_node("Main/player")
	var player_weapons = player.get_children().filter(
		func(child):
			return child is PlayerWeapon
	) as Array[PlayerWeapon]

	var processed = get_possible_upgrade_sets(player_weapons)
	var new_weapons = get_unobtained_weapons(player_weapons)

	var all_choices = processed.possible_upgrade_sets + new_weapons + get_misc_upgrades()
	var choices = choose_at_most_n(all_choices, 3)

	for choice in choices:
		# Instantiate an upgrade panel and fill in fields
		var upgrade_panel : MarginContainer = upgrade_panel_scene.instantiate()
	
		if choice is WeaponUpgradeSet:
			var weapon = processed.upgrade_set_name_to_weapon_map[choice.resource_name]
			upgrade_panel.weapon_name = weapon.display_name if weapon.display_name != null else weapon.name 
			upgrade_panel.upgrade_name = choice.resource_name
			# TODO: placeholder images
			# upgrade_panel.img_filepath = 
			upgrade_panel.mechanics = ([] as Array[String])
			for component_upgrade in choice.upgrades:
				upgrade_panel.mechanics.append(component_upgrade.resource_name)
			upgrade_panel.img_filepath = weapon.weapon_img_path
			
			upgrade_panel.on_panel_pressed = func():
				weapon.upgrades += choice.upgrades
				choice.applied = true
				weapon._reinstantiate_weapon()

				if (processed.all_possible_upgrades_length <= 1):
					hit_max_level = true
				EventBus.finish_level_up.emit()
				_on_player_finish_level_up()
		elif choice is PlayerWeapon:
			upgrade_panel.upgrade_name = choice.display_name if choice.display_name != null else choice.name
			upgrade_panel.img_filepath = choice.weapon_img_path
			upgrade_panel.mechanics = [choice.description if choice.description != null else "A new weapon!"] as Array[String]
			for mechanic in choice.base_mechanics:
				upgrade_panel.mechanics.append(mechanic as String)
			upgrade_panel.on_panel_pressed = func():
				player.add_child(choice)
				EventBus.finish_level_up.emit()
				_on_player_finish_level_up()
		elif choice is ConsumableUpgrade:
			upgrade_panel.upgrade_name = choice.display_name
			upgrade_panel.img_filepath = choice.img_filepath
			for mechanic in choice.mechanics:
				upgrade_panel.mechanics.append(mechanic as String)
			upgrade_panel.on_panel_pressed = func():
				choice._apply_upgrade(player)
				EventBus.finish_level_up.emit()
				_on_player_finish_level_up()

		h_container.add_child(upgrade_panel)

func clear_upgrade_panels():
	for child in h_container.get_children():
		if child is MarginContainer:
			child.queue_free()

func _on_player_level_up():
	if (hit_max_level):
		return
	get_tree().paused = true
	visible = true
	
	populate_upgrade_panels()


func _on_player_finish_level_up():
	clear_upgrade_panels()
	visible = false
	get_tree().paused = false

func create_start_weapon_upgrade_menu():
	visible = true

	var player = get_tree().root.get_node("Main/player")
	var starting_weapon = starting_weapon_scene.instantiate() as PlayerWeapon

	var upgrade_panel : MarginContainer = upgrade_panel_scene.instantiate()
	upgrade_panel.upgrade_name = starting_weapon.display_name if starting_weapon.display_name != null else starting_weapon.name
	upgrade_panel.img_filepath = starting_weapon.weapon_img_path
	upgrade_panel.mechanics = [starting_weapon.description if starting_weapon.description != null else "A new weapon!"] as Array[String]
	for mechanic in starting_weapon.base_mechanics:
		upgrade_panel.mechanics.append(mechanic as String)
	upgrade_panel.on_panel_pressed = func():
		player.add_child(starting_weapon)
		EventBus.start_tutorial.emit()
		_on_player_finish_level_up()
	h_container.add_child(upgrade_panel)

func new_upgrade_menu():
	visible = false
	clear_upgrade_panels()

func _on_restart_game():
	new_upgrade_menu()

func _on_switch_scenes(_scene: int):
	new_upgrade_menu()

func _ready():
	new_upgrade_menu()

	if !EventBus.switch_scenes.is_connected(_on_switch_scenes):
		EventBus.switch_scenes.connect(_on_switch_scenes)

	if !EventBus.get_starting_weapon.is_connected(create_start_weapon_upgrade_menu):
		EventBus.get_starting_weapon.connect(create_start_weapon_upgrade_menu)

	if(!EventBus.level_up.is_connected(_on_player_level_up)):
		EventBus.level_up.connect(_on_player_level_up)

	if(!EventBus.restart_game.is_connected(_on_restart_game)):
		EventBus.restart_game.connect(_on_restart_game)
