extends CanvasLayer

var starting_weapon_scene : PackedScene = load("res://scenes/player/player_weapons/ram_shield/ram_shield.tscn")
@onready var upgrade_panel_scene : PackedScene = load("res://scenes/ui/upgrade_panel.tscn")
@onready var h_container : HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer
@onready var continue_button : Button = $PanelContainer/MarginContainer/VBoxContainer/ContinueButton

var starting_weapon : PlayerWeapon

func create_start_weapon_upgrade_menu():
	visible = true

	var upgrade_panel : MarginContainer = upgrade_panel_scene.instantiate()
	# upgrade_panel.custom_minimum_size.x = 800
	# upgrade_panel.custom_maximum_size.x = 800

	upgrade_panel.upgrade_name = starting_weapon.display_name
	upgrade_panel.img_filepath = starting_weapon.weapon_img_path
	upgrade_panel.mechanics = [starting_weapon.description] as Array[String]
	for mechanic in starting_weapon.base_mechanics:
		upgrade_panel.mechanics.append(mechanic as String)
	upgrade_panel.show_button = false

	h_container.add_child(upgrade_panel)
	h_container.move_child(upgrade_panel, 0)

func _on_continue_pressed():
	var player = get_tree().root.get_node("Main/player")
	player.add_child(starting_weapon)
	EventBus.start_tutorial.emit()
	visible = false
	get_tree().paused = false

func _ready():
	continue_button.pressed.connect(_on_continue_pressed)
	starting_weapon = starting_weapon_scene.instantiate() as PlayerWeapon
	visible = false
	if !EventBus.get_starting_weapon.is_connected(create_start_weapon_upgrade_menu):
		EventBus.get_starting_weapon.connect(create_start_weapon_upgrade_menu)
