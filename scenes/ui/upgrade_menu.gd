extends CanvasLayer

@onready var upgrade_panel_scene : PackedScene = load("res://scenes/ui/upgrade_panel.tscn")
@onready var h_container : HBoxContainer = $PanelContainer/HBoxContainer

var hit_max_level = false

class UpgradeSetMetadata:
	var possible_upgrade_sets: Array[WeaponUpgradeSet] = []
	var all_possible_upgrades_length: int = 0
	var upgrade_set_name_to_weapon_map: Dictionary[String, PlayerWeapon] = {}

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

func choose_at_most_three(possible_upgrade_sets: Array[WeaponUpgradeSet]):
	var total_upgrades = possible_upgrade_sets.size()
	var num_to_choose = min(total_upgrades, 3)
	
	var sliced = possible_upgrade_sets
	sliced.shuffle()
	return sliced.slice(0, num_to_choose)

func populate_upgrade_panels():
	var player_weapons = get_tree().root.get_node("Main/player").get_children().filter(
		func(child):
			return child is PlayerWeapon
	) as Array[PlayerWeapon]

	var processed = get_possible_upgrade_sets(player_weapons)
	var choices = choose_at_most_three(processed.possible_upgrade_sets)

	for choice in choices:
		# Instantiate an upgrade panel and fill in fields
		var upgrade_panel : MarginContainer = upgrade_panel_scene.instantiate()
	
		upgrade_panel.upgrade_name = choice.resource_name
		# TODO: placeholder images
		# upgrade_panel.img_filepath = 
		upgrade_panel.mechanics = ([] as Array[String])
		for component_upgrade in choice.upgrades:
			upgrade_panel.mechanics.append(component_upgrade.resource_name)
		
		upgrade_panel.on_panel_pressed = func():
			var weapon = processed.upgrade_set_name_to_weapon_map[choice.resource_name]
			weapon.upgrades += choice.upgrades
			choice.applied = true
			weapon._reinstantiate_weapon()

			if (processed.all_possible_upgrades_length <= 1):
				hit_max_level = true
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

func new_upgrade_menu():
	visible = false
	clear_upgrade_panels()

func _on_restart_game():
	new_upgrade_menu()

func _ready():
	new_upgrade_menu()
	
	if(!EventBus.level_up.is_connected(_on_player_level_up)):
		EventBus.level_up.connect(_on_player_level_up)

	if(!EventBus.restart_game.is_connected(_on_restart_game)):
		EventBus.restart_game.connect(_on_restart_game)
