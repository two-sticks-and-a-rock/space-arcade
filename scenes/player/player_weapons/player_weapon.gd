class_name PlayerWeapon
extends Node2D

@export var bullet_scene : PackedScene

@export var dmg: int
@export var bullets: int
@export var bullet_speed: float
@export var bullet_size: float

@onready var up_timer : Timer = $UpTimer as Timer
@onready var down_timer : Timer = $DownTimer as Timer

@export var upgrades : Array[PlayerWeaponUpgrade] = []
@export var possible_upgrade_sets : Array[WeaponUpgradeSet] = []

func _reset():
	for upgrade in upgrades:
		if (!upgrade.applied):
			upgrade._apply_upgrade(self as PlayerWeapon)
			upgrade.applied = true