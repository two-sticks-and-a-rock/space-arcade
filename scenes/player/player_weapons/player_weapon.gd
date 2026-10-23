class_name PlayerWeapon
extends Node2D

@export var bullet_scene : PackedScene

"""
===== FOR UPGRADES PANEL DISPLAY ====
"""
@export var display_name : String 
@export var description : String
@export var base_mechanics : Array[String] = []

"""
===== UPGRADEABLE ATTRIBUTES ====
This is not expected to be a full complete list that all weapons ever need
If more upgradeable attributes are needed for a particular weapon, add them directly to that weapon
See the "res://scenes/player/player_weapons/frost_nova/frost_nova.gd" for an example. 
It adds a "freeze_time" attribute

Only add an attribute here if multiple weapons will need it
"""
@export var dmg: int

@export var num_bullets: int
"""
 Note: Some weapons only ever have one bullet. It's fine to just not use num_bullets
 Feel free to just instantiate the bullet directly like we do in "res://scenes/player/player_weapons/frost_nova/frost_nova.gd"
 for the Frost Nova/Cryo Pulse weapon
"""
@export var bullet_speed: float
@export var bullet_size: float

@onready var up_timer : Timer = $UpTimer as Timer
@onready var down_timer : Timer = $DownTimer as Timer

@export var upgrades : Array[WeaponUpgrade] = []
@export var possible_upgrade_sets : Array[WeaponUpgradeSet] = []

func _ready():
	_reinstantiate_weapon()

	if (!EventBus.restart_game.is_connected(_on_restart)):
		EventBus.restart_game.connect(_on_restart)

func _reset_weapon():
	for upgrade in upgrades:
		upgrade._remove_upgrade(self as PlayerWeapon)
		upgrade.applied = false

	upgrades = [] as Array[WeaponUpgrade]
	for possible_upgrade_set in possible_upgrade_sets:
		possible_upgrade_set.applied = false

func _on_restart():
	_reset_weapon()
	_reinstantiate_weapon()

func _reinstantiate_weapon():
	for upgrade in upgrades:
		if (!upgrade.applied):
			upgrade._apply_upgrade(self as PlayerWeapon)
			upgrade.applied = true

func _remove_timers():
	up_timer.process_mode = Node.PROCESS_MODE_DISABLED
	down_timer.process_mode = Node.PROCESS_MODE_DISABLED

func _add_timers():
	up_timer.process_mode = Node.PROCESS_MODE_INHERIT
	down_timer.process_mode = Node.PROCESS_MODE_INHERIT

	up_timer.start()
