class_name PlayerWeapon
extends Node2D

@export var bullet_scene : PackedScene

@export var dmg: int
@export var num_bullets: int
@export var bullet_speed: float
@export var bullet_size: float

@onready var up_timer : Timer = $UpTimer as Timer
@onready var down_timer : Timer = $DownTimer as Timer