class_name PlayerWeapon
extends Node2D

@export var bullet_scene : PackedScene

@export var dmg: int
@export var bullets: int
@export var bullet_speed: float

@onready var up_timer : Timer = $UpTimer as Timer
@onready var down_timer : Timer = $DownTimer as Timer

@export var upgrades : Array[PlayerWeaponUpgrade] = []

func apply_upgrades():
	for upgrade in upgrades:
		upgrade._apply_upgrade(self as PlayerWeapon)