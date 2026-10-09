class_name PlayerWeapon
extends Node2D

@export var bullet_scene : PackedScene

@export var dmg: int
@export var num_bullets: int
@export var bullet_speed: float
@export var bullet_size: float

@onready var up_timer : Timer = $UpTimer as Timer
@onready var down_timer : Timer = $DownTimer as Timer

@export var upgrades : Array[WeaponUpgrade] = []
@export var possible_upgrade_sets : Array[WeaponUpgradeSet] = []

func _reset_weapon():
    for upgrade in upgrades:
        upgrade._remove_upgrade(self as PlayerWeapon)
        upgrade.applied = false

    upgrades = [] as Array[WeaponUpgrade]
    for possible_upgrade_set in possible_upgrade_sets:
        possible_upgrade_set.applied = false

func _reinstantiate_weapon():
    for upgrade in upgrades:
        if (!upgrade.applied):
            upgrade._apply_upgrade(self as PlayerWeapon)
            upgrade.applied = true